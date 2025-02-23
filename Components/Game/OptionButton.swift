import SwiftUI

struct OptionButton: View {
    let option: GameOption
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(option.text)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .black)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isSelected {
                    Image(systemName: option.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .padding(.trailing, 16)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        isSelected
                        ? (option.isCorrect ? Color.green.opacity(0.9) : Color.red.opacity(0.9))
                        : Color.white.opacity(0.9)
                    )
                    .shadow(color: isSelected ? .black.opacity(0.4) : .black.opacity(0.2), 
                            radius: isSelected ? 10 : 5, 
                            x: 0, 
                            y: isSelected ? 5 : 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .scaleEffect(isSelected ? 1.03 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
