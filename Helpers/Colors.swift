import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct Colors {
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "#BEE6BE")
    static let blueText = Color(hex: "#004064")
    
    static let buttonGradientTop = Color(hex: "#BAF1A3")
    static let buttonGradientBottom = Color(hex: "#014B3F")
    
    static let gradientRedTop = Color(hex: "#F02D2D")
    static let gradientRedBottom = Color(hex: "#900000")
    
    static let gradientGreenTop = Color(hex:"#BAF1A3")
    static let gradientGreenBottom = Color(hex:"#6AAD4F")

    static let earthBlue = Color(hex: "#3F91BE")
    static let seaBlue = Color(hex: "#004064")
    static let earthGreen = Color(hex: "#6A8D73")
    static let spaceLightBlue = Color(hex: "#004064")
    static let spaceDarkBlue = Color(hex: "#08233C")
}

