
protocol LibraryService {
    func fetchLearningStrands(then handle: (Result<LearningStrand, Error>) -> Void)
    func fetchInProgressObjectives(then handle: (Result<LearningObjective, Error>) -> Void)
    func fetchRecommendationObjectives(then handle: (Result<LearningObjective, Error>) -> Void)
}

