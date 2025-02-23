import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = GameDataViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Colors.spaceLightBlue,
                            Colors.spaceDarkBlue
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: max(geometry.size.width, geometry.size.height) / 2
                    )
                    .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            Text("🌿 Eco Hero’s Quest")
                                .font(.system(size: min(geometry.size.width * 0.1, 64), weight: .bold, design: .rounded))
                                .foregroundColor(Colors.textPrimary)
                                .padding(.top, 60)
                            
                            CarbonFootprintView(carbonPoints: $viewModel.carbonPoints)
                                .padding(.horizontal, 20)
                            
                            if viewModel.isLoading {
                                ProgressView("Loading levels...")
                            } else {
                                LevelsView(levels: viewModel.gameLevels, carbonPoints: $viewModel.carbonPoints)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .frame(maxWidth: 800)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.loadGameData()
            }
        }
    }
}
