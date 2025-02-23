import SwiftUI

struct QuestionView: View {
    let currentQuestion: GameQuestion
    
    var body: some View {
        Text(currentQuestion.text)
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4)
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [Colors.gradientGreenTop.opacity(0.7), Colors.gradientGreenBottom.opacity(0.9)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.black.opacity(0.1))
                }
                    .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 5)
            )
    }
}

