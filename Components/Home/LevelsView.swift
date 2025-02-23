import SwiftUI

struct LevelsView: View {
    let levels: [GameLevel]
    @Binding var carbonPoints: Double
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(levels) { level in
                LevelCard(level: level, carbonPoints: $carbonPoints)
                    .scaleEffect(level.unlocked ? 1.0 : 0.97)
                    .animation(.easeInOut(duration: 0.3), value: level.unlocked)
            }
        }
        .frame(maxWidth: 600)
        .padding(.top, 10)
    }
}
