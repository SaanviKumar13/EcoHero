import SwiftUI

struct StarPosition: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let opacity: Double
    let animationOffset: CGFloat
    let animationDuration: Double
}

struct CompletionView: View {
    let ecoPointsReduced: Double
    var onDismiss: (() -> Void)?
    @Binding var carbonPoints: Double
    
    @State private var showContent = false
    @State private var bounceText = false
    @State private var scaleEarth = 1.0
    @State private var rotateEmoji = false
    @State private var starPhase = false
    
    private let numberOfStars = 150
    @State private var stars: [StarPosition] = []
    
    private var earthsSaved: Double {
        (max(1, 1 + (carbonPoints / 1111)) - (carbonPoints-ecoPointsReduced)/1111)
    }
    
    private var motivationalMessage: String {
        switch ecoPointsReduced {
        case 800...:
            return "🌍 INCREDIBLE! You’re leading the green revolution! 🚀"
        case 600..<800:
            return "🌱 SUPERSTAR! The planet thanks you! 🌟"
        case 400..<600:
            return "🌿 AMAZING! Every action makes a difference! 💚"
        case 250..<400:
            return "🌎 GREAT JOB! You’re making an impact! ✨"
        case 100..<250:
            return "🍃 WELL DONE! Keep protecting the Earth! 🌏"
        case 50..<100:
            return "🌍 GOOD START! Small steps lead to big changes! 🏆"
        case 10..<50:
            return "💚 NICE EFFORT! Every bit counts! Keep going! 🌟"
        default:
            return "🚀 BEGINNER ECO HERO! The journey starts now! 🌱"
        }
    }
    
    init(ecoPointsReduced: Double, onDismiss: (() -> Void)? = nil, carbonPoints: Binding<Double>) {
        self.ecoPointsReduced = ecoPointsReduced
        self.onDismiss = onDismiss
        self._carbonPoints = carbonPoints
    }
    
    var body: some View {
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
                
                ForEach(stars) { star in
                    Circle()
                        .fill(Color.white)
                        .frame(width: star.size, height: star.size)
                        .position(
                            x: star.x + (starPhase ? star.animationOffset : 0),
                            y: star.y + (starPhase ? star.animationOffset : 0)
                        )
                        .shadow(color: .yellow.opacity(0.8), radius: 2)
                        .opacity(star.opacity)
                        .animation(
                            Animation.easeInOut(duration: star.animationDuration)
                                .repeatForever(autoreverses: true),
                            value: starPhase
                        )
                }
                
                VStack(spacing: 25) {
                    Spacer()
                    
                    Text("🎉 Level Completed! 🎉")
                        .font(.system(size: min(geometry.size.width * 0.1, 40), weight: .bold, design: .rounded))
                        .foregroundColor(Colors.textPrimary)
                        .scaleEffect(bounceText ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: bounceText)
                        .shadow(radius: 5)
                        .opacity(showContent ? 1 : 0)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Label("Eco Points Earned", systemImage: "leaf.fill")
                                .font(.system(size: min(geometry.size.width * 0.05, 24), weight: .bold))
                                .foregroundColor(.green)
                        }
                        
                        Text("\(Int(ecoPointsReduced))")
                            .font(.system(size: min(geometry.size.width * 0.1, 50), weight: .bold))
                            .foregroundColor(.green)
                    }
                    .padding()
                    .frame(width: min(geometry.size.width * 0.8, 300))
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .opacity(showContent ? 1 : 0)
                    
                    VStack(spacing: 15) {
                        Label("Earths Saved", systemImage: "globe")
                            .font(.system(size: min(geometry.size.width * 0.05, 24), weight: .bold))
                            .foregroundColor(.blue)
                        
                        Text("🌍")
                            .font(.system(size: min(geometry.size.width * 0.1, 60)))
                            .scaleEffect(scaleEarth)
                        
                        Text(String(format: "%.2f", earthsSaved))
                            .font(.system(size: min(geometry.size.width * 0.08, 40), weight: .bold))
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(width: min(geometry.size.width * 0.8, 300))
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .opacity(showContent ? 1 : 0)
                    
                    Text(motivationalMessage)
                        .font(.system(size: min(geometry.size.width * 0.05, 24), weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .scaleEffect(bounceText ? 1.05 : 1.0)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .opacity(showContent ? 1 : 0)
                    
                    Button(action: { onDismiss?() }) {
                        HStack {
                            Text("🏠")
                                .font(.system(size: min(geometry.size.width * 0.06, 28)))
                            
                            Text("Back to Home")
                                .font(.system(size: min(geometry.size.width * 0.05, 24), weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: min(geometry.size.width * 0.7, 240))
                        .background(
                            ZStack {
                                Color.black.opacity(0.1)
                                LinearGradient(
                                    colors: [Colors.buttonGradientTop, Colors.buttonGradientBottom],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                        )
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    }
                    .opacity(showContent ? 1 : 0)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width)
                .padding(.vertical, 30)
            }
            .onAppear {
                stars = generateStars(in: geometry.size)
                withAnimation(.easeInOut(duration: 0.1)) {
                    starPhase = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeOut(duration: 1.0)) {
                        showContent = true
                    }
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        bounceText = true
                        scaleEarth = 1.2
                    }
                    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                        rotateEmoji = true
                    }
                }
            }
        }
    }
    
    private func generateStars(in size: CGSize) -> [StarPosition] {
        var stars: [StarPosition] = []
        for _ in 0..<numberOfStars {
            let animDuration = Double.random(in: 15...25)
            stars.append(StarPosition(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height),
                size: CGFloat.random(in: 2...4),
                opacity: Double.random(in: 0.3...1.0),
                animationOffset: CGFloat.random(in: -100...50),
                animationDuration: animDuration
            ))
        }
        return stars
    }
}
