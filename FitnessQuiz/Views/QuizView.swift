import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
            progressHeader

            if let question = viewModel.currentQuestion {
                DSCard {
                    VStack(alignment: .leading, spacing: DSSpacing.stackGap) {
                        if viewModel.isRepeatRound {
                            Text("WIEDERHOLUNG")
                                .font(DSFont.micro)
                                .foregroundColor(DSColor.accent)
                        }
                        Text(question.text)
                            .font(DSFont.question)
                            .foregroundColor(DSColor.textPrimary)
                    }
                }

                VStack(spacing: DSSpacing.cardGap) {
                    ForEach(Array(question.answers.enumerated()), id: \.offset) { index, answer in
                        answerRow(index: index, text: answer, question: question)
                    }
                }

                Spacer()

                if viewModel.isAnswered {
                    NextButton(action: viewModel.advanceToNextQuestion)
                        .id(question.id)
                }
            }
        }
        .padding(DSSpacing.screenGutter)
    }

    private var progressHeader: some View {
        HStack {
            Text(viewModel.selectedCategory.displayName)
                .font(DSFont.screenTitle)
                .foregroundColor(DSColor.textPrimary)
            Spacer()
            Text(viewModel.selectedDifficulty.displayName)
                .font(DSFont.caption)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding(.top, DSSpacing.s24)
    }

    /// Background/border for one answer row, derived once instead of two
    /// separately-branching closures.
    private func rowStyle(isCorrectAnswer: Bool, isSelected: Bool) -> (background: Color, border: Color) {
        guard viewModel.isAnswered else { return (DSColor.surfaceCard, .clear) }
        if isCorrectAnswer { return (DSColor.correct.opacity(0.25), DSColor.correct) }
        if isSelected { return (DSColor.incorrect.opacity(0.25), DSColor.incorrect) }
        return (DSColor.surfaceCard, .clear)
    }

    private func answerRow(index: Int, text: String, question: Question) -> some View {
        let isSelected = viewModel.selectedAnswerIndex == index
        let isCorrectAnswer = index == question.correctAnswerIndex
        let style = rowStyle(isCorrectAnswer: isCorrectAnswer, isSelected: isSelected)

        return Button {
            viewModel.submitAnswer(index)
        } label: {
            DSCard(background: style.background, borderColor: style.border) {
                HStack {
                    Text(text)
                        .font(DSFont.body)
                        .foregroundColor(DSColor.textPrimary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if viewModel.isAnswered && isCorrectAnswer {
                        DSIcon(name: "check", size: 16)
                            .foregroundColor(DSColor.correct)
                    }
                }
            }
            .frame(minHeight: DSSpacing.tapMin)
        }
        .buttonStyle(DSPressable())
        .disabled(viewModel.isAnswered)
    }
}

/// Wraps the "Weiter" action with a one-shot guard: `.id(question.id)` on
/// the call site gives each question a fresh instance, so `hasAdvanced`
/// blocks a rapid double-tap from calling `advanceToNextQuestion()` twice
/// (which would silently skip a question) without needing a manual reset.
private struct NextButton: View {
    let action: () -> Void
    @State private var hasAdvanced = false

    var body: some View {
        DSButton(title: "Weiter", variant: .accent, fullWidth: true) {
            guard !hasAdvanced else { return }
            hasAdvanced = true
            action()
        }
    }
}
