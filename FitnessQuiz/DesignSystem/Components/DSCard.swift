import SwiftUI

/// Surface adapted from `components/core/Card.jsx`: flat fill, no border,
/// no shadow — depth in this system comes from a stepped surface value,
/// not elevation.
enum DSCardTone {
    case card, inset

    var background: Color {
        switch self {
        case .card: return DSColor.surfaceCard
        case .inset: return DSColor.surfaceInset
        }
    }
}

struct DSCard<Content: View>: View {
    var tone: DSCardTone = .card
    var padding: CGFloat = DSSpacing.s12
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(tone.background)
            .clipShape(RoundedRectangle(cornerRadius: DSRadius.card, style: .continuous))
    }
}
