import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: QuizViewModel

    private var percentageLabel: String {
        guard viewModel.firstPassTotal > 0 else { return "0%" }
        let pct = Int((Double(viewModel.firstPassCorrect) / Double(viewModel.firstPassTotal)) * 100)
        return "\(pct)%"
    }

    private var isNewHighScore: Bool {
        viewModel.firstPassCorrect > 0 && viewModel.firstPassCorrect >= viewModel.bestScore
    }

    var body: some View {
        ZStack(alignment: .top) {
            DSColor.headerWash
                .frame(height: 220)
                .ignoresSafeArea(edges: .top)

            ScrollView {
                VStack(spacing: DSSpacing.sectionGap) {
                    Text("Ergebnis")
                        .font(DSFont.greeting)
                        .foregroundColor(DSColor.textPrimary)
                        .padding(.top, DSSpacing.s24)

                    if isNewHighScore {
                        Text("Neuer Bestwert!")
                            .font(DSFont.label)
                            .foregroundColor(DSColor.accent)
                    }

                    DSProgressRing(value: viewModel.firstPassCorrect, max: viewModel.firstPassTotal, label: percentageLabel)

                    HStack(spacing: DSSpacing.cardGap) {
                        DSStatTile(
                            label: "Richtig",
                            icon: "check",
                            value: "\(viewModel.firstPassCorrect)/\(viewModel.firstPassTotal)",
                            valueColor: DSColor.correct
                        )
                        DSStatTile(
                            label: "Wiederholt gemeistert",
                            icon: "rotate-ccw",
                            value: "\(viewModel.repeatCorrect)"
                        )
                    }

                    DSStatTile(
                        label: "Bestwert (\(viewModel.selectedCategory.displayName))",
                        icon: "chart-column",
                        value: "\(viewModel.bestScore)/\(viewModel.firstPassTotal)"
                    )

                    VStack(spacing: DSSpacing.cardGap) {
                        DSButton(title: "Nochmal", icon: "rotate-ccw", variant: .accent, size: .lg, fullWidth: true) {
                            viewModel.startQuiz()
                        }
                        DSButton(title: "Zurück zum Start", icon: "house", variant: .outline, size: .lg, fullWidth: true) {
                            viewModel.reset()
                        }
                    }
                    .padding(.top, DSSpacing.s8)
                }
                .padding(DSSpacing.screenGutter)
            }
        }
    }
}
