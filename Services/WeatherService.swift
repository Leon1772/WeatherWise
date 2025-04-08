import Foundation
import Combine

class WeatherService: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(for location: String) {
        guard let url = URL(string: "\(Config.baseURL)/weather?q=\(location)&units=\(Config.Weather.temperatureUnit)&appid=\(Config.openWeatherAPIKey)") else {
            errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Weather.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] weather in
                self?.currentWeather = weather
                self?.checkForBadges(weather: weather)
            })
            .store(in: &cancellables)
    }
    
    private func checkForBadges(weather: Weather) {
        // Implement badge checking logic here
        // This will be called whenever new weather data is received
    }
}

struct Weather: Codable {
    let main: Main
    let weather: [WeatherInfo]
    let name: String
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case humidity
        }
    }
    
    struct WeatherInfo: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
} 