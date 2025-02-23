import Foundation

struct GameData: Codable {
    let gameLevels: [GameLevel]
}

struct GameLevel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let backgroundImage: String
    let unlocked: Bool
    let questions: [GameQuestion]
    let requiredEarths: Double?
}

struct GameQuestion: Codable {
    let text: String
    let options: [GameOption]
    let explanation: String
    let backgroundImage: String
    let factTitle: String
    let interestingFact: String
    let impactCategory: String
    let difficultyLevel: Int
}

struct GameOption: Codable, Equatable, Identifiable {
    let id:String
    let text: String
    let isCorrect: Bool
    let carbonImpact: Double
}

