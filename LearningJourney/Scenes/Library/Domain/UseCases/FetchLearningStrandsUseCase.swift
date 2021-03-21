protocol FetchLearningStrandsUseCase {
    func execute(then handle: (Result<[LearningStrand], Error>) -> Void)
}
