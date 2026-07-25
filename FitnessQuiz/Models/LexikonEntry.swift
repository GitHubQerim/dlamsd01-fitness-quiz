import Foundation

/// MoSCoW priority for the Lexikon's content curriculum: the order in which
/// someone building up nutrition/training fundamentals should learn a term.
enum ContentPriority: Int, Comparable, CaseIterable {
    case must, should, could

    static func < (lhs: ContentPriority, rhs: ContentPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    var sectionTitle: String {
        switch self {
        case .must: return "Fundamentals"
        case .should: return "Vertiefung"
        case .could: return "Extras"
        }
    }
}

struct LexikonEntry: Identifiable, Hashable {
    let id: String
    let title: String
    let category: QuizCategory
    let priority: ContentPriority
    let summary: String
    let details: String
}
