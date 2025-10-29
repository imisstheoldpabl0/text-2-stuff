import SwiftUI
import AVKit

struct VideoGenerationView: View {
    let model: Model
    @StateObject private var viewModel = GenerationViewModel()
    @State private var prompt = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.name)
                        .font(.title2)
                        .bold()
                    Text(model.description)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                TextField("Enter your prompt", text: $prompt, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)

                Button(action: {
                    Task {
                        let modelKey = model.id.split(separator: "/").last.map(String.init) ?? ""
                        await viewModel.generateVideo(
                            modelKey: modelKey,
                            prompt: prompt
                        )
                    }
                }) {
                    if viewModel.isGenerating {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Generate")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(prompt.isEmpty || viewModel.isGenerating)

                if !viewModel.progress.isEmpty {
                    Text(viewModel.progress)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }

                if let videoURL = viewModel.generatedVideoURL {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 300)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
            }
            .padding()
        }
        .navigationTitle("Generate Video")
        .navigationBarTitleDisplayMode(.inline)
    }
}
