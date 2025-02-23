import SwiftUI

struct NextButton: View {
    let isLastQuestion: Bool
    let moveToNextQuestion: () -> Void
    
    var body: some View {
        Button(action: moveToNextQuestion) {
            HStack {
                Text(isLastQuestion ? "Finish Challenge" : "Next Question")
                    .font(.system(size: 18, weight: .bold))
                
                Image(systemName: isLastQuestion ? "flag.checkered" : "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    colors: isLastQuestion ? 
                    [Color.purple.opacity(0.8), Color.blue.opacity(0.8)] :
                        [Color.green.opacity(0.8), Color.blue.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
            .padding(.vertical, 10)
        }
        .transition(.scale)
    }
}
