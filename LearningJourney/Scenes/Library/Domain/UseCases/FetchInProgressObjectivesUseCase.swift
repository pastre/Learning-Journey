protocol FetchInProgressObjectivesUseCase {
    func execute(then handle: (Result<[LearningObjective], Error>) -> Void)
}

