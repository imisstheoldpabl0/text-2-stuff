import SwiftUI

struct ModelSelectionView: View {
    let models: [Model]

    var imageModels: [Model] {
        models.filter { $0.type == "image" }
    }

    var videoModels: [Model] {
        models.filter { $0.type == "video" }
    }

    var body: some View {
        List {
            if !imageModels.isEmpty {
                Section("Image Generation") {
                    ForEach(imageModels) { model in
                        NavigationLink(destination: ImageGenerationView(model: model)) {
                            ModelCard(model: model)
                        }
                    }
                }
            }

            if !videoModels.isEmpty {
                Section("Video Generation") {
                    ForEach(videoModels) { model in
                        NavigationLink(destination: VideoGenerationView(model: model)) {
                            ModelCard(model: model)
                        }
                    }
                }
            }
        }
    }
}
