import SwiftUI

/// Browsable reference screen, grouped as a must/should/could learning
/// curriculum. Presented as a sheet (with its own internal NavigationStack
/// for list→detail) from both StartView and QuizView's "Mehr erfahren"
/// link — see ContentView's comment on why the app doesn't use a
/// top-level NavigationStack.
struct LexikonView: View {
    @State private var selectedCategory: QuizCategory?
    @Environment(\.dismiss) private var dismiss

    /// Pre-filters the browser to one category, e.g. when opened from the
    /// result screen for the category just played.
    init(initialCategory: QuizCategory? = nil) {
        _selectedCategory = State(initialValue: initialCategory)
    }

    private var groupedEntries: [(priority: ContentPriority, entries: [LexikonEntry])] {
        ContentPriority.allCases.compactMap { priority in
            let entries = LexikonBank.all.filter {
                $0.priority == priority && (selectedCategory == nil || $0.category == selectedCategory)
            }
            return entries.isEmpty ? nil : (priority, entries)
        }
    }

    var body: some View {
        NavigationStack {
            DSWashedScreen {
                VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
                    header
                    categoryFilter
                    if groupedEntries.isEmpty {
                        emptyState
                    } else {
                        ForEach(groupedEntries, id: \.priority) { group in
                            sectionView(priority: group.priority, entries: group.entries)
                        }
                    }
                }
            }
            .navigationDestination(for: LexikonEntry.self) { entry in
                LexikonDetailView(entry: entry)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Schließen") { dismiss() }
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: DSSpacing.s4) {
            Text("Lexikon")
                .font(DSFont.greeting)
                .foregroundColor(DSColor.textPrimary)
            Text("Grundlagen zu Ernährung und Training zum Nachlesen.")
                .font(DSFont.body)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding(.top, DSSpacing.s24)
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DSSpacing.cardGap) {
                DSChip(title: "Alle", active: selectedCategory == nil) {
                    selectedCategory = nil
                }
                .fixedSize()
                ForEach(QuizCategory.allCases) { category in
                    DSChip(title: category.displayName, icon: category.iconName, active: selectedCategory == category) {
                        selectedCategory = category
                    }
                    .fixedSize()
                }
            }
        }
    }

    private var emptyState: some View {
        Text("Für diese Kategorie sind noch keine Einträge vorhanden.")
            .font(DSFont.body)
            .foregroundColor(DSColor.textSecondary)
            .padding(.top, DSSpacing.sectionGap)
    }

    private func sectionView(priority: ContentPriority, entries: [LexikonEntry]) -> some View {
        VStack(alignment: .leading, spacing: DSSpacing.cardGap) {
            Text(priority.sectionTitle.uppercased())
                .font(DSFont.label)
                .foregroundColor(DSColor.textTertiary)
            VStack(spacing: DSSpacing.cardGap) {
                ForEach(entries) { entry in
                    NavigationLink(value: entry) {
                        entryRow(entry)
                    }
                }
            }
        }
    }

    private func entryRow(_ entry: LexikonEntry) -> some View {
        DSCard {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title)
                        .font(DSFont.body)
                        .foregroundColor(DSColor.textPrimary)
                    Text(entry.summary)
                        .font(DSFont.caption)
                        .foregroundColor(DSColor.textSecondary)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(DSColor.textTertiary)
            }
        }
    }
}
