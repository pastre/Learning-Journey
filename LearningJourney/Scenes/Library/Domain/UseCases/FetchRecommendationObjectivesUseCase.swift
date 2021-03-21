protocol FetchRecommendationObjectivesUseCase {
    func execute(then handle: (Result<[LearningObjective], Error>) -> Void)
}
