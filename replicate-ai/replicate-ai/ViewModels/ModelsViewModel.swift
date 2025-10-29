import Foundation
import Combine

@MainActor
class ModelsViewModel: ObservableObject {
    @Published var models: [Model] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadModels() async {
        isLoading = true
        errorMessage = nil

        do {
            let modelsDict = try await APIService.shared.fetchModels()
            models = Array(modelsDict.values).sorted { $0.name < $1.name }
        } catch {
            errorMessage = "Failed to load models: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
