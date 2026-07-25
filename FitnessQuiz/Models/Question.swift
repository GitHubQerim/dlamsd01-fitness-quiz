import Foundation

struct Question: Identifiable {
    let id = UUID()
    let category: QuizCategory
    let difficulty: Difficulty
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int

    var correctAnswer: String { answers[correctAnswerIndex] }

    /// Returns a copy with `answers` in a random order and `correctAnswerIndex`
    /// remapped to match. The question catalog authors the correct answer
    /// first for readability, so this must run before a question is
    /// presented — otherwise the correct answer is index 0 every time.
    func shuffled() -> Question {
        let correct = answers[correctAnswerIndex]
        let shuffledAnswers = answers.shuffled()
        let newIndex = shuffledAnswers.firstIndex(of: correct) ?? correctAnswerIndex
        return Question(category: category, difficulty: difficulty, text: text, answers: shuffledAnswers, correctAnswerIndex: newIndex)
    }
}
