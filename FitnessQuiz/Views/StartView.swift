import SwiftUI

/// Reports a card's own rendered height so sibling cards can match it —
/// `reduce` keeps the tallest, so two cards with different amounts of text
/// (e.g. at large Dynamic Type sizes) can still end up exactly the same size.
private struct DashboardTileHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

/// Dashboard-style layout: one full-width "Quiz" card (mode picker +
/// start), then a 2-column row (Lexikon / about the project) — mirrors
/// the source design system's own card-grid dashboard.
struct StartView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var showingLexikon = false
    /// Measured (not hard-coded) so the Lexikon/about tiles always match
    /// height exactly, however much text either one wraps to.
    @State private var dashboardTileHeight: CGFloat?

    private var totalQuestions: Int {
        QuestionBank.questions(for: viewModel.selectedCategory, difficulty: viewModel.selectedDifficulty).count
    }

    var body: some View {
        DSWashedScreen {
            VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
                header
                quizCard
                HStack(spacing: DSSpacing.cardGap) {
                    lexikonCard
                    aboutCard
                }
                .onPreferenceChange(DashboardTileHeightKey.self) { dashboardTileHeight = $0 }
            }
        }
        .sheet(isPresented: $showingLexikon) {
            LexikonView()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: DSSpacing.s4) {
            Text("Hallo! Lust zu lernen?")
                .font(DSFont.body)
                .foregroundColor(DSColor.textSecondary)
            Text("Fitness-Quiz")
                .font(DSFont.score)
                .foregroundColor(DSColor.textPrimary)
        }
        .padding(.top, DSSpacing.s24)
    }

    private var quizCard: some View {
        DSCard(padding: DSSpacing.s16) {
            VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
                sectionLabel("Quiz")

                VStack(alignment: .leading, spacing: DSSpacing.stackGap) {
                    sectionLabel("Kategorie")
                    categoryPicker

                    sectionLabel("Schwierigkeit")
                    difficultyPicker
                }

                DSStatTile(
                    label: "Bestwert",
                    icon: "chart-column",
                    value: "\(viewModel.bestScore)/\(totalQuestions)"
                )

                DSButton(title: "Quiz starten", icon: "dumbbell", variant: .accent, fullWidth: true) {
                    viewModel.startQuiz()
                }
            }
        }
    }

    private var lexikonCard: some View {
        Button {
            showingLexikon = true
        } label: {
            DSCard(minHeight: dashboardTileHeight) {
                cardContent(icon: "info", title: "Lexikon", subtitle: "Grundlagen nachlesen")
            }
            .measuringDashboardTileHeight()
        }
        .buttonStyle(DSPressable())
    }

    private var aboutCard: some View {
        DSCard(minHeight: dashboardTileHeight) {
            cardContent(
                icon: "heart-pulse",
                title: "Über dieses Projekt",
                subtitle: "Ein kleines Projekt, um Trainings- und Ernährungswissen spielerisch zu festigen."
            )
        }
        .measuringDashboardTileHeight()
    }

    private func cardContent(icon: String, title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: DSSpacing.s8) {
            DSIcon(name: icon, size: 20)
                .foregroundColor(DSColor.accent)
            Text(title)
                .font(DSFont.body)
                .foregroundColor(DSColor.textPrimary)
            Text(subtitle)
                .font(DSFont.caption)
                .foregroundColor(DSColor.textSecondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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

private extension View {
    /// Reports this view's rendered height via `DashboardTileHeightKey`
    /// without affecting layout (the `GeometryReader` sits in a zero-size
    /// background, it never influences this view's own size).
    func measuringDashboardTileHeight() -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(key: DashboardTileHeightKey.self, value: proxy.size.height)
            }
        )
    }
}
