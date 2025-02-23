import SwiftUI

struct LevelCard: View {
    let level: GameLevel
    @Binding var carbonPoints: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(level.unlocked ? Colors.seaBlue : Color(.systemGray6))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                .frame(height: 160)
            
            if level.unlocked {
                NavigationLink(destination: GameView(level: level, carbonPoints: $carbonPoints)) {
                    levelCardContent
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                levelCardContent
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(.trailing, 20)
                        }
                    )
            }
        }
        .padding(.horizontal, 12)
    }
    
    private var levelCardContent: some View {
        HStack(spacing: 25) {
            Image(level.backgroundImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(level.unlocked ? Colors.earthBlue : Color.gray, lineWidth: 3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(level.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(level.unlocked ? .white : .gray)
                
                Text(level.description)
                    .font(.title2)
                    .foregroundColor(level.unlocked ? .white.opacity(0.85) : .gray)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(22)
    }
}
