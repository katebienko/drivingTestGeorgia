import Foundation

struct Tickets: Codable {
    let id: Int
    let name: String
    let email: String
    let answers: Answers
    let phone: String
}

struct Answers: Codable {
    let street: String
    let zipcode: String
}
