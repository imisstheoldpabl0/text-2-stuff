import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = Config.apiBaseURL

    private init() {}

    func fetchModels() async throws -> [String: Model] {
        let url = URL(string: "\(baseURL)/models")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ModelsResponse.self, from: data)
        return response.models
    }

    func createPrediction(modelKey: String, input: [String: Any]) async throws -> Prediction {
        let url = URL(string: "\(baseURL)/predictions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "modelKey": modelKey,
            "input": input
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PredictionResponse.self, from: data)
        return response.prediction
    }

    func getPrediction(id: String) async throws -> Prediction {
        let url = URL(string: "\(baseURL)/predictions/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PredictionResponse.self, from: data)
        return response.prediction
    }

    func pollPrediction(id: String, maxAttempts: Int = 60) async throws -> Prediction {
        for _ in 0..<maxAttempts {
            let prediction = try await getPrediction(id: id)

            if prediction.status == "succeeded" || prediction.status == "failed" {
                return prediction
            }

            try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        }

        throw NSError(domain: "APIService", code: -1,
                     userInfo: [NSLocalizedDescriptionKey: "Prediction timeout"])
    }
}
