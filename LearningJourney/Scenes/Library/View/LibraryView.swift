//
//  LibraryView.swift
//  LearningJourney
//
//  Created by Bruno Pastre on 19/03/21.
//

import SwiftUI
import Neumorphic

struct LibraryView: View {
    @Environment(\.appEnvironment) var appEnvironment: AppEnvironment
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(viewModel.sections, id: \.name) { section in
                    buildQuickActionSection(
                        title: section.name,
                        using: section.objectives
                    )
                }
                .padding()
                VStack {
                    ForEach(viewModel.strands, id: \.name) { strand in
                        HStack {
                            Text(strand.name)
                            Spacer()
                            Image(systemName: "chevron")
                        }
                    }
                }
            }
        }
        .background(Color.Neumorphic.main)
        .onAppear {
            viewModel.initialize()
        }
    }
    
    private func buildQuickActionSection(title: String, using objectives: [LearningObjective]) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(objectives, id: \.id) { objective in
                            ObjectiveView(objective: objective)
                        }
                    }
                }
            }
        }
    }
    
    private func buildStrandsSection(using strands: [LearningStrand]) -> some View{
        VStack(spacing:100) {
            ForEach(strands, id: \.name) { strand in
                Spacer()
                HStack {
                    Text(strand.name)
                    Spacer()
                    Image(systemName: "chevron.compact.left")
                }
                Spacer()
            }
        }
    }
}


extension LibraryView {
    final class ViewModel: ObservableObject {
        struct Section {
            let name: String
            let objectives: [LearningObjective]
        }
        
        @Published var sections: [Section] = []
        @Published var strands: [LearningStrand] = []
        
        // MARK: - Inner types
        struct Dependencies {
            let fetchInProgressObjectives: FetchInProgressObjectivesUseCase
            let fetchRecommendationObjectivesUseCase: FetchRecommendationObjectivesUseCase
            let fetchLearningStrandsUseCase: FetchLearningStrandsUseCase
        }
        
        // MARK: - Dependencies
        
        private let dependencies: Dependencies
        
        // MARK: - Initialization
        
        init(dependencies: Dependencies) {
            self.dependencies = dependencies
        }
        	        
        // MARK: - LibraryDisplayLogic
        func initialize() {
            dependencies.fetchInProgressObjectives.execute {
                switch $0 {
                case let .success(objectives):
                    self.sections.append(.init(
                        name: "In Progress",
                        objectives: objectives
                    ))
                case let .failure(error):
                    print("Erro! \(error)")
                }
            }
            dependencies.fetchRecommendationObjectivesUseCase.execute {
                switch $0 {
                case let .success(objectives):
                    self.sections.append(.init(
                        name: "Recommendations",
                        objectives: objectives
                    ))
                case let .failure(error):
                    print("Error fetching recommendations! \(error)")
                }
            }
            dependencies.fetchLearningStrandsUseCase.execute { (result) in
                switch result {
                case let .success(strands):
                    self.strands = strands
                case let .failure(error): print("Error fetching strands! \(error)")
                }
            }
        }
    }
    
}

#if DEBUG
struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(viewModel: .init(dependencies: .init(
            fetchInProgressObjectives: PreviewFetchInProgressObjectivesUseCase(),
            fetchRecommendationObjectivesUseCase: PreviewFetchRecommendationObjectivesUseCase(),
            fetchLearningStrandsUseCase: PreviewFetchLearningStrandsUseCase()
        )))
        .previewDevice("iPhone 8")
    }
}

final class PreviewFetchInProgressObjectivesUseCase: FetchInProgressObjectivesUseCase {
    func execute(then handle: (Result<[LearningObjective], Error>) -> Void) {
        handle(.success([
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Learn about monetization and business decisions that need to be made when planning the development of an app."
            ),
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Learn about monetization and business decisions that need to be made when planning the development of an app."
            ),
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Learn about monetization and business decisions that need to be made when planning the development of an app."
            ),
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Learn about monetization and business decisions that need to be made when planning the development of an app."
            ),
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Learn about monetization and business decisions that need to be made when planning the development of an app."
            ),
        ]))
    }
}

final class PreviewFetchRecommendationObjectivesUseCase: FetchRecommendationObjectivesUseCase {
    func execute(then handle: (Result<[LearningObjective], Error>) -> Void) {
        handle(.success([
            .init(
                coreKeywords: [],
                electiveKeywords: [],
                name: "Mock"
            )
        ]))
    }
}

final class PreviewFetchLearningStrandsUseCase: FetchLearningStrandsUseCase {
    func execute(then handle: (Result<[LearningStrand], Error>) -> Void) {
        handle(.success([
            .init(
                name: "Design",
                goals: []
            ),
            .init(
                name: "Design",
                goals: []
            ),
            .init(
                name: "Design",
                goals: []
            ),
            .init(
                name: "Design",
                goals: []
            ),
        ]))
    }
}
#endif
