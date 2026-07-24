import SwiftUI

/// Button adapted from `components/core/Button.jsx`.
enum DSButtonVariant {
    case accent, light, outline, ghost

    var background: Color {
        switch self {
        case .accent: return DSColor.accent
        case .light: return DSColor.nWhite
        case .outline, .ghost: return .clear
        }
    }

    var foreground: Color {
        switch self {
        case .accent: return DSColor.textOnInvert
        case .light: return DSColor.textOnInvert
        case .outline: return DSColor.textPrimary
        case .ghost: return DSColor.textTertiary
        }
    }

    var border: Color? {
        self == .outline ? DSColor.borderStrong : nil
    }
}

enum DSButtonSize {
    case md, lg

    var height: CGFloat {
        switch self {
        case .md: return 34
        case .lg: return 52
        }
    }

    var horizontalPadding: CGFloat {
        switch self {
        case .md: return 14
        case .lg: return 20
        }
    }

    var font: Font {
        switch self {
        case .md: return DSFont.label
        case .lg: return DSFont.body
        }
    }
}

struct DSButton: View {
    let title: String
    var icon: String? = nil
    var variant: DSButtonVariant = .light
    var size: DSButtonSize = .md
    var fullWidth: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon {
                    DSIcon(name: icon, size: size == .lg ? 18 : 14)
                }
                Text(title)
                    .font(size.font)
            }
            .foregroundColor(variant.foreground)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .frame(minHeight: size.height)
            .padding(.horizontal, size.horizontalPadding)
            .background(variant.background)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(variant.border ?? .clear, lineWidth: 1)
            )
        }
        .buttonStyle(DSPressable())
    }
}
