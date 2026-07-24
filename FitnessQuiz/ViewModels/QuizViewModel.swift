import Foundation
import Combine

/// Drives the quiz flow: question selection, answer evaluation, the
/// end-of-round repeat pass for wrongly answered questions, and the
/// per-category/difficulty high score.
@MainActor
final class QuizViewModel: ObservableObject {
    enum Phase {
        case selecting
        case playing
        case finished
    }

    @Published var selectedCategory: QuizCategory = .trainingslehre
    @Published var selectedDifficulty: Difficulty = .leicht
    @Published private(set) var phase: Phase = .selecting

    @Published private(set) var currentQuestion: Question?
    @Published private(set) var selectedAnswerIndex: Int?
    @Published private(set) var isAnswered = false
    @Published private(set) var isRepeatRound = false

    /// Correct answers on the first attempt — this is the score that counts
    /// towards the high score, so re-answering a repeated question can't
    /// inflate it.
    @Published private(set) var firstPassCorrect = 0
    @Published private(set) var firstPassTotal = 0
    @Published private(set) var repeatCorrect = 0

    private var queue: [Question] = []
    private var missedQuestions: [Question] = []
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func startQuiz() {
        let questions = QuestionBank.questions(for: selectedCategory, difficulty: selectedDifficulty).shuffled()
        queue = questions
        missedQuestions = []
        firstPassCorrect = 0
        firstPassTotal = questions.count
        repeatCorrect = 0
        isRepeatRound = false
        phase = .playing
        advanceToNextQuestion()
    }

    func submitAnswer(_ index: Int) {
        guard let question = currentQuestion, !isAnswered else { return }
        selectedAnswerIndex = index
        isAnswered = true

        let isCorrect = index == question.correctAnswerIndex
        if isRepeatRound {
            if isCorrect { repeatCorrect += 1 }
        } else if isCorrect {
            firstPassCorrect += 1
        } else {
            missedQuestions.append(question)
        }
    }

    func advanceToNextQuestion() {
        selectedAnswerIndex = nil
        isAnswered = false

        if !queue.isEmpty {
            currentQuestion = queue.removeFirst()
            return
        }

        if !isRepeatRound && !missedQuestions.isEmpty {
            isRepeatRound = true
            queue = missedQuestions.shuffled()
            missedQuestions = []
            currentQuestion = queue.removeFirst()
            return
        }

        currentQuestion = nil
        finishQuiz()
    }

    func reset() {
        phase = .selecting
        currentQuestion = nil
    }

    var bestScore: Int {
        highScore(for: selectedCategory, difficulty: selectedDifficulty)
    }

    func highScore(for category: QuizCategory, difficulty: Difficulty) -> Int {
        defaults.integer(forKey: highScoreKey(for: category, difficulty: difficulty))
    }

    private func finishQuiz() {
        phase = .finished
        let key = highScoreKey(for: selectedCategory, difficulty: selectedDifficulty)
        if firstPassCorrect > defaults.integer(forKey: key) {
            defaults.set(firstPassCorrect, forKey: key)
        }
    }

    private func highScoreKey(for category: QuizCategory, difficulty: Difficulty) -> String {
        "highscore.\(category.rawValue).\(difficulty.rawValue)"
    }
}
