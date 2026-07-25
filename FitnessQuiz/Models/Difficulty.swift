import Foundation

enum Difficulty: String, CaseIterable, Identifiable {
    case leicht, mittel, schwer

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .leicht: return "Leicht"
        case .mittel: return "Mittel"
        case .schwer: return "Schwer"
        }
    }
}
