import SwiftUI

/// Flow controller: swaps between the three screens based on the
/// view model's `phase` instead of a navigation stack, since the quiz
/// has no back-stack semantics — going "back" mid-quiz isn't meaningful.
struct ContentView: View {
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        ZStack {
            DSColor.surfaceBase.ignoresSafeArea()

            switch viewModel.phase {
            case .selecting:
                StartView(viewModel: viewModel)
            case .playing:
                QuizView(viewModel: viewModel)
            case .finished:
                ResultView(viewModel: viewModel)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
