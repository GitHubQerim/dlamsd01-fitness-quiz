import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var showingLexikon = false

    private var percentageLabel: String {
        guard viewModel.firstPassTotal > 0 else { return "0%" }
        let pct = Int((Double(viewModel.firstPassCorrect) / Double(viewModel.firstPassTotal)) * 100)
        return "\(pct)%"
    }

    /// Only offer the Lexikon link if the played category actually has
    /// entries — the Lexikon currently only covers Ernährung topics.
    private var hasLexikonContentForCategory: Bool {
        LexikonBank.all.contains { $0.category == viewModel.selectedCategory }
    }

    var body: some View {
        DSWashedScreen {
            VStack(spacing: DSSpacing.sectionGap) {
                Text("Ergebnis")
                    .font(DSFont.greeting)
                    .foregroundColor(DSColor.textPrimary)
                    .padding(.top, DSSpacing.s24)

                if viewModel.isNewHighScore {
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

                if hasLexikonContentForCategory {
                    DSButton(title: "Mehr im Lexikon zu \(viewModel.selectedCategory.displayName) →", icon: "info", variant: .outline, fullWidth: true) {
                        showingLexikon = true
                    }
                }

                VStack(spacing: DSSpacing.cardGap) {
                    DSButton(title: "Nochmal", icon: "rotate-ccw", variant: .accent, fullWidth: true) {
                        viewModel.startQuiz()
                    }
                    DSButton(title: "Zurück zum Start", icon: "house", variant: .outline, fullWidth: true) {
                        viewModel.reset()
                    }
                }
                .padding(.top, DSSpacing.s8)
            }
        }
        .sheet(isPresented: $showingLexikon) {
            LexikonView(initialCategory: viewModel.selectedCategory)
        }
    }
}
