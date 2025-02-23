import SwiftUI

struct ExplanationView: View {
    @Binding var selectedOption: GameOption?
    let currentQuestion: GameQuestion
    
    var body: some View {
        VStack(spacing: 20) {
            if let option = selectedOption {
                HStack {
                    Image(systemName: option.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(option.isCorrect ? .green : .red)
                    
                    Text(option.isCorrect ? "Great choice!" : "Not quite right")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal, 5)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Why it matters:")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                Text(currentQuestion.explanation)
                    .font(.system(size: 28))
                    .foregroundColor(.white.opacity(0.9))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
                
                if let option = selectedOption {
                    HStack {
                        Image(systemName: option.isCorrect ? "leaf.fill" : "exclamationmark.triangle.fill")
                            .foregroundColor(option.isCorrect ? .green : .orange)
                            .font(.system(size: 22))
                        
                        VStack(alignment: .leading) {
                            Text(option.isCorrect ? "Carbon Reduction:" : "Carbon Impact:")
                                .font(.system(size: 28, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(option.isCorrect ? 
                                 "-\(String(format: "%.1f", abs(option.carbonImpact))) points" :
                                    "+\(String(format: "%.1f", abs(option.carbonImpact))) points")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(option.isCorrect ? Color.green.opacity(0.3) : Color.orange.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(option.isCorrect ? Color.green : Color.orange, lineWidth: 1)
                            )
                    )
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.6))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
        }
        .transition(.opacity)
    }
}
