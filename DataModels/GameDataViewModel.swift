import Foundation 

class GameDataViewModel: ObservableObject {
    @Published var gameLevels: [GameLevel] = []
    @Published var isLoading = true
    @Published var carbonPoints: Double {
        didSet {
            UserDefaults.standard.set(carbonPoints, forKey: "carbonPoints")
        }
    }
    
    init() {
        self.carbonPoints = UserDefaults.standard.double(forKey: "carbonPoints")
        if self.carbonPoints == 0 {
            self.carbonPoints = 10000.0
        }
        
        loadGameData()
    }
    
    func loadGameData() {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: "GameData", withExtension: "json") else {
                print("JSON file not found!")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(GameData.self, from: data)
                DispatchQueue.main.async {
                    self.gameLevels = decodedData.gameLevels
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}

