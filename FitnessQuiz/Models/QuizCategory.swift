import Foundation

enum QuizCategory: String, CaseIterable, Identifiable {
    case trainingslehre
    case ernaehrung
    case uebungsausfuehrung

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .trainingslehre: return "Trainingslehre"
        case .ernaehrung: return "Ernährung"
        case .uebungsausfuehrung: return "Übungsausführung"
        }
    }

    /// Design-system icon name (see FitnessQuiz/Assets.xcassets).
    var iconName: String {
        switch self {
        case .trainingslehre: return "brain"
        case .ernaehrung: return "flame"
        case .uebungsausfuehrung: return "dumbbell"
        }
    }
}
