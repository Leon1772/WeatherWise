import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var weatherService: WeatherService
    @State private var location: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dynamic background based on weather
                backgroundView
                
                VStack(spacing: 20) {
                    // Location input
                    HStack {
                        TextField("Enter location", text: $location)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Button(action: {
                            weatherService.fetchWeather(for: location)
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                    
                    if let weather = weatherService.currentWeather {
                        // Weather information
                        VStack(spacing: 10) {
                            Text(weather.name)
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("\(Int(weather.main.temp))°")
                                .font(.system(size: 72, weight: .thin))
                                .foregroundColor(.white)
                            
                            Text(weather.weather.first?.description.capitalized ?? "")
                                .font(.title2)
                                .foregroundColor(.white)
                            
                            HStack(spacing: 30) {
                                WeatherDetailView(
                                    icon: "humidity",
                                    value: "\(weather.main.humidity)%",
                                    label: "Humidity"
                                )
                                
                                WeatherDetailView(
                                    icon: "thermometer",
                                    value: "\(Int(weather.main.feelsLike))°",
                                    label: "Feels Like"
                                )
                            }
                        }
                    } else if let error = weatherService.errorMessage {
                        Text(error)
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("WeatherWise")
        }
    }
    
    private var backgroundView: some View {
        Group {
            if let weather = weatherService.currentWeather {
                switch weather.weather.first?.main.lowercased() {
                case "clear":
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .yellow]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                case "clouds":
                    LinearGradient(
                        gradient: Gradient(colors: [.gray, .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                case "rain":
                    LinearGradient(
                        gradient: Gradient(colors: [.gray, .blue]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                default:
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct WeatherDetailView: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }
} 