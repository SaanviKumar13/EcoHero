import SwiftUI

struct InfoToggleButton: View {
    @Binding var showInfoCard: Bool
    @Binding var infoButtonRotation: Double
    @Binding var infoButtonScale: CGFloat
    
    var body: some View {
        Button(action: { 
            withAnimation(.spring()) {
                showInfoCard.toggle()
            }
            
            infoButtonRotation = 0
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                infoButtonScale = 1.1
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 14))
                    .opacity(showInfoCard ? 0 : 0.9)
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                center: .center,
                                startRadius: 5,
                                endRadius: 30
                            )
                        )
                        .frame(width: 38, height: 38)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    
                    Image(systemName: showInfoCard ? "lightbulb.fill" : "lightbulb")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Text(showInfoCard ? "Hide Fun Facts" : "Discover Fun Facts!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 14))
                    .opacity(showInfoCard ? 0 : 0.9)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: showInfoCard ? 
                            [Color.purple.opacity(0.7), Color.blue.opacity(0.7)] :
                                [Color.orange.opacity(0.7), Color.yellow.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.7), Color.white.opacity(0.3)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1.5
                            )
                    )
            )
        }
        .rotationEffect(.degrees(infoButtonRotation))
        .scaleEffect(infoButtonScale)
    }
}
