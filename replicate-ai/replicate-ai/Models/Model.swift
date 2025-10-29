import Foundation

struct Model: Codable, Identifiable {
    let id: String
    let name: String
    let type: String
    let description: String
    let free: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, type, description, free
    }
}

struct ModelsResponse: Codable {
    let success: Bool
    let models: [String: Model]
}
