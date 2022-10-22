import Foundation

struct Tickets: Codable {
    let number: Int
    let question: String
    let image: String?
    let answers: Answers
}

struct Answers: Codable {
    let answer1: String
    let answer2: String
    let answer3: String?
    let answer4: String?
}
