import SwiftUI

struct StartView: View {
    @ObservedObject var viewModel: QuizViewModel

    private var totalQuestions: Int {
        QuestionBank.questions(for: viewModel.selectedCategory, difficulty: viewModel.selectedDifficulty).count
    }

    var body: some View {
        ZStack(alignment: .top) {
            DSColor.headerWash
                .frame(height: 220)
                .ignoresSafeArea(edges: .top)

            ScrollView {
                VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
                    header

                    sectionLabel("Kategorie")
                    categoryPicker

                    sectionLabel("Schwierigkeit")
                    difficultyPicker

                    DSStatTile(
                        label: "Bestwert",
                        icon: "chart-column",
                        value: "\(viewModel.bestScore)/\(totalQuestions)"
                    )

                    DSButton(title: "Quiz starten", icon: "dumbbell", variant: .accent, size: .lg, fullWidth: true) {
                        viewModel.startQuiz()
                    }
                    .padding(.top, DSSpacing.s8)
                }
                .padding(DSSpacing.screenGutter)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: DSSpacing.s4) {
            Text("Fitness-Quiz")
                .font(DSFont.greeting)
                .foregroundColor(DSColor.textPrimary)
            Text("Trainiere dein Wissen zu Training, Ernährung und Übungsausführung.")
                .font(DSFont.body)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding(.top, DSSpacing.s24)
    }

    private func sectionLabel(_ title: String) -> some View {
        Text(title.uppercased())
            .font(DSFont.label)
            .foregroundColor(DSColor.textTertiary)
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DSSpacing.cardGap) {
                ForEach(QuizCategory.allCases) { category in
                    DSChip(title: category.displayName, icon: category.iconName, active: viewModel.selectedCategory == category) {
                        viewModel.selectedCategory = category
                    }
                    .fixedSize()
                }
            }
        }
    }

    private var difficultyPicker: some View {
        HStack(spacing: DSSpacing.cardGap) {
            ForEach(Difficulty.allCases) { difficulty in
                DSChip(title: difficulty.displayName, active: viewModel.selectedDifficulty == difficulty) {
                    viewModel.selectedDifficulty = difficulty
                }
            }
        }
    }
}
