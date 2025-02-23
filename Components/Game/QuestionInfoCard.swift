import SwiftUI

struct QuestionInfoCard: View {
    let currentQuestion: GameQuestion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: getCategoryIcon(currentQuestion.impactCategory))
                        .foregroundColor(.white)
                    
                    Text(currentQuestion.impactCategory)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(getCategoryColor(currentQuestion.impactCategory))
                )
                
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(1...3, id: \.self) { level in
                        Image(systemName: level <= currentQuestion.difficultyLevel ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.system(size: 14))
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                    
                    Text(currentQuestion.factTitle)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text(currentQuestion.interestingFact)
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color.indigo.opacity(0.7), Color.purple.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
        )
        .transition(.asymmetric(
            insertion: .scale(scale: 0.8).combined(with: .opacity),
            removal: .scale(scale: 0.8).combined(with: .opacity)
        ))
    }
    
    private func getCategoryIcon(_ category: String) -> String {
        switch category.lowercased() {
        case "water conservation": return "drop.fill"
        case "energy conservation": return "bolt.fill"
        case "waste reduction": return "trash.fill"
        case "transportation": return "car.fill"
        case "ecosystem preservation": return "leaf.fill"
        case "air quality": return "wind"
        default: return "globe.americas.fill"
        }
    }
    
    private func getCategoryColor(_ category: String) -> Color {
        switch category.lowercased() {
        case "water conservation": return Color.blue.opacity(0.8)
        case "energy conservation": return Color.yellow.opacity(0.8)
        case "waste reduction": return Color.purple.opacity(0.8)
        case "transportation": return Color.green.opacity(0.8)
        case "ecosystem preservation": return Color.orange.opacity(0.8)
        case "air quality": return Color.cyan.opacity(0.8)
        default: return Color.indigo.opacity(0.8)
        }
    }
}
