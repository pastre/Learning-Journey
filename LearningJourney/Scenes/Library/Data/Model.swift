import SwiftUI

typealias LearningObjective = LearningStrand.LearningGoal.LearningObjective

struct LearningStrand {
    let name: String
    let goals: [LearningGoal]
    struct LearningGoal {
        let name: String
        let shortName: String
        let objectives: [LearningObjective]
        struct LearningObjective {
            let id = UUID()
            let coreKeywords: [String]
            let electiveKeywords: [String]
            let name: String
        }
    }
}
