import Foundation

enum Config {
    static let openWeatherAPIKey = "YOUR_API_KEY_HERE" // Replace with your OpenWeatherMap API key
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    
    enum Weather {
        static let temperatureUnit = "metric" // Use "imperial" for Fahrenheit
        static let updateInterval: TimeInterval = 1800 // 30 minutes
    }
    
    enum Badges {
        static let rainStreakThreshold = 3 // Days of consecutive rain
        static let temperatureExtremeThreshold = 30 // Celsius
        static let weatherVarietyThreshold = 5 // Different weather types
    }
} 