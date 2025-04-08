import Foundation

enum Config {
    static let openWeatherAPIKey = "71c1cab8bb49f98aabcd920a40562be0"
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    
    enum Weather {
        static let temperatureUnit = "metric" // Use "imperial" for Fahrenheit
    }
    
    enum Calendar {
        static let calendarAccessMessage = "WeatherWise needs access to your calendar to provide personalized activity recommendations based on weather conditions."
    }
} 