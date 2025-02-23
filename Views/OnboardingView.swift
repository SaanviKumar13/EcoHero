import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    
    let storyData = [
        ("real_earth", "space", "🌍 Wow! Look at Earth from up here!\n\nIt's like a beautiful blue marble, spinning in the vastness of space. See how the oceans sparkle, and the clouds dance across the land. Earth is our home, a very special place."),
        
        ("heated_earth", "space_polluted", "😞 But wait... the scientists are showing us something.\n\nThese images tell a different story! Our earth is getting warmer. The ice caps are melting, and the oceans are rising. However some parts are facing droughts and water shortages. Deforestation, pollution and overuse of resources are key problems.\n\nHowever the good news is that each one of us can do something about it."),
        
        ("real_earth", "space", "✨ The world has commited to zero carbon emissions.\n\nA zero carbon emission plan means that we reduce pollution and do not add extra carbon dioxide to the air. For example, using solar and wind energy instead of burning coal, oil or gas can reduce carbon emissions.\n\nIt also means saving natural resources and making small changes in our daily lives.\n\nRemember it takes a HERO to get to ZERO (Zero emissions) 🌍💚")
    ]
    
    @State private var storyText = "🌍 Wow! Look at Earth from up here!\n\nIt's like a beautiful blue marble, spinning in the vastness of space. See how the oceans sparkle, and the clouds dance across the land. Earth is our home, a very special place."
    @State private var showOnboarding = true
    @State private var imageOpacity = 1.0
    @State private var bgOpacity = 1.0
    @State private var imageScale: CGFloat = 1.0
    @State private var spinAngle: Double = 5
    @State private var transitioning = false
    
    var body: some View {
        if showOnboarding {
            ZStack {
                Image(storyData[currentIndex].1)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(bgOpacity)
                    .animation(.easeInOut(duration: 1), value: currentIndex)
                    .id(currentIndex)
                
                HStack(spacing: 40) {
                    ZStack {
                        ForEach(0..<storyData.count, id: \.self) { index in
                            if index == currentIndex || transitioning {
                                Image(storyData[index].0)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width * 0.45)
                                    .opacity(index == currentIndex ? imageOpacity : 0)
                                    .scaleEffect(index == currentIndex ? imageScale : 1.2)
                                    .rotationEffect(.degrees(spinAngle))
                                    .animation(.linear(duration: 100).repeatForever(), value: spinAngle)
                                    .animation(.easeInOut(duration: 1), value: currentIndex)
                            }
                        }
                    }
                    
                    VStack {
                        Text(storyText)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Colors.textPrimary)
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.45)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(20)
                        
                        Button(action: nextScene) {
                            Text(currentIndex == storyData.count - 1 ? "Let's see how!" : "Next")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 220)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Colors.buttonGradientTop, Colors.buttonGradientBottom]), startPoint: .top, endPoint: .bottom)
                                )
                                .foregroundColor(.black)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 40)
            }
            .onAppear {
                startSpin()
            }
        }
    }
    
    func nextScene() {
        if currentIndex < storyData.count - 1 {
            transitioning = true
            
            withAnimation(.easeInOut(duration: 0.5)) {
                imageOpacity = 0
                imageScale = 0.8
                bgOpacity = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                currentIndex += 1
                storyText = storyData[currentIndex].2
                
                withAnimation(.easeInOut(duration: 0.8)) {
                    imageOpacity = 1
                    imageScale = 1
                    bgOpacity = 1
                }
                
                startSpin()
                transitioning = false
            }
        } else {
            showOnboarding = false
            navigateToHome()
        }
    }
    
    func startSpin() {
        spinAngle = 0
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
            spinAngle = 360
        }
    }
    
    func navigateToHome() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: HomeView())
            window.makeKeyAndVisible()
        }
    }
}

