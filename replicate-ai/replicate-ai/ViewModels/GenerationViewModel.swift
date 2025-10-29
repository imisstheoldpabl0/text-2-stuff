import Foundation
import UIKit
import Combine

@MainActor
class GenerationViewModel: ObservableObject {
    @Published var isGenerating = false
    @Published var generatedImage: UIImage?
    @Published var generatedVideoURL: URL?
    @Published var errorMessage: String?
    @Published var progress: String = ""

    func generateImage(modelKey: String, prompt: String) async {
        isGenerating = true
        errorMessage = nil
        generatedImage = nil
        progress = "Creating prediction..."

        do {
            let input = ["prompt": prompt]
            let prediction = try await APIService.shared.createPrediction(
                modelKey: modelKey,
                input: input
            )

            progress = "Generating image..."
            let completedPrediction = try await APIService.shared.pollPrediction(id: prediction.id)

            if completedPrediction.status == "succeeded",
               let output = completedPrediction.output,
               let urlString = output.value as? String,
               let url = URL(string: urlString) {

                progress = "Downloading image..."
                let (data, _) = try await URLSession.shared.data(from: url)
                generatedImage = UIImage(data: data)
                progress = "Done!"
            } else {
                throw NSError(domain: "Generation", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: completedPrediction.error ?? "Unknown error"])
            }
        } catch {
            errorMessage = "Generation failed: \(error.localizedDescription)"
        }

        isGenerating = false
    }

    func generateVideo(modelKey: String, prompt: String) async {
        isGenerating = true
        errorMessage = nil
        generatedVideoURL = nil
        progress = "Creating prediction..."

        do {
            let input = ["prompt": prompt]
            let prediction = try await APIService.shared.createPrediction(
                modelKey: modelKey,
                input: input
            )

            progress = "Generating video..."
            let completedPrediction = try await APIService.shared.pollPrediction(id: prediction.id)

            if completedPrediction.status == "succeeded",
               let output = completedPrediction.output,
               let urlString = output.value as? String,
               let url = URL(string: urlString) {

                generatedVideoURL = url
                progress = "Done!"
            } else {
                throw NSError(domain: "Generation", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: completedPrediction.error ?? "Unknown error"])
            }
        } catch {
            errorMessage = "Generation failed: \(error.localizedDescription)"
        }

        isGenerating = false
    }
}
