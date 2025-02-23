import SwiftUI

struct CarbonFootprintView: View {
    @Binding var carbonPoints: Double  
    @State private var displayedEarths: Double = 10  
    @State private var showInfoPopup = false  
    
    var earthsNeeded: Double {
        max(1, 1 + (carbonPoints / 1111))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("How Many Earths? 🌎")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(Colors.textPrimary)

            HStack {
                Text("If everyone lived like you, we'd need")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                Button(action: {
                    showInfoPopup.toggle()
                }) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
                .popover(isPresented: $showInfoPopup) {
                    VStack(spacing: 12) {
                        Text("🌱 Reduce Your Impact!")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Text("The more Earths we need, the more we harm the planet! Make choices that help reduce the number of Earths needed. 💚")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Got it! 👍") {
                            showInfoPopup = false
                        }
                        .font(.headline)
                        .foregroundColor(Colors.textPrimary)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .frame(width: 300)
                    .padding()
                }
            }
            
            Text("\(Int(earthsNeeded))")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(Colors.textPrimary)
                .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)
                .padding()
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(
                                colors: earthsNeeded > 5 ? [Colors.gradientRedTop, Colors.gradientRedBottom] :
                                    earthsNeeded > 1 ? [.yellow, .orange] :
                                    [Colors.seaBlue, Colors.earthGreen],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .padding(0)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.2))
                    }
                )
            
            HStack(spacing: 5) {
                ForEach(0..<Int(displayedEarths), id: \.self) { _ in
                    Image(systemName: "globe.americas.fill")
                        .font(.system(size: 40))
                        .foregroundColor(displayedEarths > 5 ? Colors.gradientRedTop :
                                            displayedEarths > 3 ? .orange :
                                .green)
                        .shadow(color: displayedEarths > 5 ? Color.red.opacity(0.5) :
                                    displayedEarths > 3 ? Color.orange.opacity(0.4) :
                                    Color.green.opacity(0.3),
                                radius: 3)
                }
            }
            .frame(width: 260)
            .padding(.vertical, 5)
            .onAppear {
                displayedEarths = earthsNeeded
            }
            .onChange(of: earthsNeeded) { newValue in
                withAnimation(.easeOut(duration: 1.5)) {
                    displayedEarths = newValue
                }
            }
        }
        .padding(.horizontal)
    }
}

