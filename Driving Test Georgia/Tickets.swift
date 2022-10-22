import Foundation

struct Tickets: Codable {
    let number: Int
    let image: String?
    let question: String
    let answers: [Answers]
}

struct Answers: Codable {
    let text: String
    let correct: Bool
}
