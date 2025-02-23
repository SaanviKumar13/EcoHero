import SwiftUI

struct HeaderView: View {
    let level: GameLevel
    
    var body: some View {
        VStack(spacing: 10) {
            Text(level.name.uppercased())
                .font(.system(size: 50, weight: .black))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
        }
    }
}
