import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ModelsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading models...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text("Error")
                            .font(.headline)
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.loadModels() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    ModelSelectionView(models: viewModel.models)
                }
            }
            .navigationTitle("AI Models")
            .task {
                await viewModel.loadModels()
            }
        }
    }
}
