//
//  ContentView.swift
//  LearningJourney
//
//  Created by Bruno Pastre on 19/03/21.
//

import SwiftUI
import Neumorphic


struct ContentView: View {
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
