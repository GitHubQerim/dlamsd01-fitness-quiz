import Foundation

struct Question: Identifiable {
    let id = UUID()
    let category: QuizCategory
    let difficulty: Difficulty
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int

    var correctAnswer: String { answers[correctAnswerIndex] }
}
