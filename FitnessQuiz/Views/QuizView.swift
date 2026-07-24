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
                    DSButton(title: "Weiter", variant: .accent, size: .lg, fullWidth: true) {
                        viewModel.advanceToNextQuestion()
                    }
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

    private func answerRow(index: Int, text: String, question: Question) -> some View {
        let isSelected = viewModel.selectedAnswerIndex == index
        let isCorrectAnswer = index == question.correctAnswerIndex

        let backgroundColor: Color = {
            guard viewModel.isAnswered else { return DSColor.surfaceCard }
            if isCorrectAnswer { return DSColor.correct.opacity(0.25) }
            if isSelected { return DSColor.incorrect.opacity(0.25) }
            return DSColor.surfaceCard
        }()

        let borderColor: Color = {
            guard viewModel.isAnswered else { return .clear }
            if isCorrectAnswer { return DSColor.correct }
            if isSelected { return DSColor.incorrect }
            return .clear
        }()

        return Button {
            viewModel.submitAnswer(index)
        } label: {
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
            .padding(DSSpacing.s12)
            .frame(maxWidth: .infinity, minHeight: DSSpacing.tapMin, alignment: .leading)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: DSRadius.card, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DSRadius.card, style: .continuous)
                    .stroke(borderColor, lineWidth: 1.5)
            )
        }
        .buttonStyle(DSPressable())
        .disabled(viewModel.isAnswered)
    }
}
