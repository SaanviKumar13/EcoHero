import SwiftUI

struct GameView: View {
    let level: GameLevel
    @Binding var carbonPoints: Double
    @State private var currentQuestionIndex = 0
    @State private var selectedOption: GameOption? = nil
    @State private var showExplanation = false
    @State private var showCompletionSheet = false
    @State private var navigateToHome = false
    @State private var animateProgress = false
    @State private var totalPointsReduced: Double = 0
    @State private var showInfoCard = false
    @State private var infoButtonRotation = 0.0
    @State private var infoButtonScale: CGFloat = 1.0
    
    private let initialCarbonPoints: Double
    
    init(level: GameLevel, carbonPoints: Binding<Double>) {
        self.level = level
        self._carbonPoints = carbonPoints
        self.initialCarbonPoints = carbonPoints.wrappedValue
    }
    
    private var currentQuestion: GameQuestion {
        guard currentQuestionIndex < level.questions.count else {
            return level.questions[0]
        }
        return level.questions[currentQuestionIndex]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Image(currentQuestion.backgroundImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                    
                    LinearGradient(
                        colors: [Color.black.opacity(0.7), Color.black.opacity(0.4)],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                .blur(radius: showCompletionSheet ? 10 : 0)
                .ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            Spacer()
                                .frame(height: geometry.size.height * 0.1)
                            
                            VStack(spacing: 20) {
                                Text("\(currentQuestionIndex + 1) / \(level.questions.count)")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(
                                        Capsule()
                                            .fill(Color.black.opacity(0.6))
                                            .overlay(Capsule().stroke(Color.white.opacity(0.6), lineWidth: 1))
                                    )
                                
                                HeaderView(level: level)
                                ProgressTrackerView(carbonPoints: $carbonPoints)
                                
                                VStack(spacing: 16) {
                                    QuestionView(currentQuestion: currentQuestion)
                                    
                                    if !showExplanation {
                                        InfoToggleButton(
                                            showInfoCard: $showInfoCard,
                                            infoButtonRotation: $infoButtonRotation,
                                            infoButtonScale: $infoButtonScale
                                        )
                                    }
                                    
                                    if showInfoCard && !showExplanation {
                                        QuestionInfoCard(currentQuestion: currentQuestion)
                                    }
                                }
                                
                                OptionsView(
                                    currentQuestion: currentQuestion,
                                    selectedOption: $selectedOption,
                                    showExplanation: $showExplanation,
                                    handleOptionSelection: handleOptionSelection
                                )
                                
                                if showExplanation {
                                    ExplanationView(
                                        selectedOption: $selectedOption,
                                        currentQuestion: currentQuestion
                                    )
                                    NextButton(
                                        isLastQuestion: isLastQuestion,
                                        moveToNextQuestion: moveToNextQuestion
                                    )
                                }
                            }
                            .frame(width: min(geometry.size.width * 0.85, 500))
                        }
                    }
        
                    Text("Background image by Freepik")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.bottom, 10)
                }
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showCompletionSheet) {
            CompletionView(
                ecoPointsReduced: totalPointsReduced,
                onDismiss: {
                    showCompletionSheet = false
                    navigateToHome = true
                },
                carbonPoints: $carbonPoints
            )
        }
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
        .onAppear {
            startProgressAnimation()
        }
    }
    
    private var isLastQuestion: Bool {
        currentQuestionIndex == level.questions.count - 1
    }
    
    private func startProgressAnimation() {
        withAnimation(.easeInOut(duration: 1.0)) {
            animateProgress = true
        }
    }
    
    private func handleOptionSelection(_ option: GameOption) {
        selectedOption = option
        showInfoCard = false
        
        withAnimation(.spring()) {
            showExplanation = true
            
            if option.isCorrect {
                carbonPoints = carbonPoints - abs(option.carbonImpact)
                totalPointsReduced += abs(option.carbonImpact)
            } else {
                carbonPoints = carbonPoints + abs(option.carbonImpact)
            }
        }
    }
    
    private func moveToNextQuestion() {
        if isLastQuestion {
            showCompletionSheet = true
        } else {
            withAnimation {
                currentQuestionIndex += 1
                selectedOption = nil
                showExplanation = false
                showInfoCard = false
                animateProgress = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    startProgressAnimation()
                }
            }
        }
    }
}

