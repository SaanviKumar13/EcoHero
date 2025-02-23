import SwiftUI

struct OptionsView: View {
    let currentQuestion: GameQuestion
    @Binding var selectedOption: GameOption?
    @Binding var showExplanation: Bool
    let handleOptionSelection: (GameOption) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(currentQuestion.options) { option in
                OptionButton(
                    option: option,
                    isSelected: selectedOption == option,
                    isDisabled: selectedOption != nil,
                    action: { handleOptionSelection(option) }
                )
            }
        }
        .padding(.vertical, 10)
    }
}
