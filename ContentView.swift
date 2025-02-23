import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    @State private var earthRotation: Double = 0
    @State private var viewOpacity = 0.0  
    
    var body: some View {
        ZStack {
            Image("space")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Eco Hero")
                    .font(.system(size: 100, weight: .bold, design: .serif))
                    .foregroundColor(Colors.textPrimary)
                
                Image("earth")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                    .rotationEffect(.degrees(earthRotation))
                    .animation(Animation.linear(duration: 60).repeatForever(autoreverses: false), value: earthRotation)
                    .onAppear {
                        earthRotation = 360
                    }
                
                Text("Earth is in Danger...\nOnly You Can Save It!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.textSecondary)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.0)) { 
                        viewOpacity = 0.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        showOnboarding = true
                    }
                }) {
                    Text("Take Action Now")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(25) 
                        .frame(width: 260, height: 80) 
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Colors.buttonGradientTop, Colors.buttonGradientBottom]), startPoint: .top, endPoint: .bottom)
                        )
                        .foregroundColor(Colors.blueText)
                        .cornerRadius(25) 
                        .shadow(radius: 5)
                }
                .padding(.top, 10)
            }
            .padding()
            .opacity(viewOpacity) 
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    viewOpacity = 1.0 
                }
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView()
            }
        }
    }
}

