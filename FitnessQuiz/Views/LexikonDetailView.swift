import SwiftUI

struct LexikonDetailView: View {
    let entry: LexikonEntry
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        DSWashedScreen {
            VStack(alignment: .leading, spacing: DSSpacing.sectionGap) {
                header

                DSCard {
                    Text(entry.details)
                        .font(DSFont.body)
                        .foregroundColor(DSColor.textSecondary)
                }

                DSButton(title: "Schließen", variant: .outline, fullWidth: true) {
                    dismiss()
                }
                .padding(.top, DSSpacing.s8)
            }
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: DSSpacing.s8) {
            HStack(spacing: 5) {
                DSIcon(name: entry.category.iconName, size: 12)
                Text("\(entry.category.displayName) · \(entry.priority.sectionTitle)")
                    .font(DSFont.label)
            }
            .foregroundColor(DSColor.accent)

            Text(entry.title)
                .font(DSFont.greeting)
                .foregroundColor(DSColor.textPrimary)

            Text(entry.summary)
                .font(DSFont.body)
                .foregroundColor(DSColor.textSecondary)
        }
        .padding(.top, DSSpacing.s24)
    }
}
