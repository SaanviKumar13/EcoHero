import SwiftUI

struct ProgressTrackerView: View {
    @Binding var carbonPoints: Double
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.green)
                
                Text("Carbon Footprint")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(String(format: "%.1f pts", carbonPoints))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 100, height: 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            colors: [.green, .green.opacity(0.6)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(
                        width: max(0, 100 * CGFloat(carbonPoints) / 10000),
                        height: 10
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .animation(.easeInOut(duration: 1.5), value: carbonPoints)
            }
            .frame(width: 100, height: 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.black.opacity(0.5))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        )
    }
}
