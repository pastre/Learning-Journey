import SwiftUI
import Neumorphic

struct ContentView: View {
    
    @Environment(\.appState) var appState: AppState
    
    var body: some View {
        LibraryView(viewModel: .init(dependencies: .init(
            fetchInProgressObjectives: PreviewFetchInProgressObjectivesUseCase(),
            fetchRecommendationObjectivesUseCase: PreviewFetchRecommendationObjectivesUseCase(),
            fetchLearningStrandsUseCase: PreviewFetchLearningStrandsUseCase()
        )))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
