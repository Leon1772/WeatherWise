import SwiftUI

struct OutfitView: View {
    @EnvironmentObject var weatherService: WeatherService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let weather = weatherService.currentWeather {
                        // Temperature-based outfit suggestions
                        temperatureBasedOutfit(temperature: weather.main.temp)
                        
                        // Weather condition-based suggestions
                        weatherConditionBasedOutfit(condition: weather.weather.first?.main ?? "")
                        
                        // Activity suggestions
                        activitySuggestions(temperature: weather.main.temp, condition: weather.weather.first?.main ?? "")
                    } else {
                        Text("Enter a location to get outfit suggestions")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .navigationTitle("Outfit Suggestions")
        }
    }
    
    private func temperatureBasedOutfit(temperature: Double) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Temperature-Based Outfit")
                .font(.headline)
            
            if temperature < 10 {
                OutfitSuggestionCard(
                    title: "Cold Weather",
                    items: ["Heavy coat", "Sweater", "Scarf", "Gloves", "Warm pants"],
                    icon: "snow"
                )
            } else if temperature < 20 {
                OutfitSuggestionCard(
                    title: "Cool Weather",
                    items: ["Light jacket", "Long-sleeve shirt", "Jeans"],
                    icon: "cloud"
                )
            } else {
                OutfitSuggestionCard(
                    title: "Warm Weather",
                    items: ["T-shirt", "Shorts", "Sunglasses"],
                    icon: "sun.max"
                )
            }
        }
    }
    
    private func weatherConditionBasedOutfit(condition: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weather-Specific Items")
                .font(.headline)
            
            switch condition.lowercased() {
            case "rain":
                OutfitSuggestionCard(
                    title: "Rainy Day",
                    items: ["Raincoat", "Umbrella", "Waterproof shoes"],
                    icon: "cloud.rain"
                )
            case "snow":
                OutfitSuggestionCard(
                    title: "Snowy Day",
                    items: ["Winter boots", "Thermal layers", "Beanie"],
                    icon: "snow"
                )
            default:
                OutfitSuggestionCard(
                    title: "Clear Day",
                    items: ["Sunglasses", "Sunscreen", "Hat"],
                    icon: "sun.max"
                )
            }
        }
    }
    
    private func activitySuggestions(temperature: Double, condition: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Activity Suggestions")
                .font(.headline)
            
            if temperature > 25 && condition.lowercased() == "clear" {
                OutfitSuggestionCard(
                    title: "Outdoor Activities",
                    items: ["Beach day", "Picnic", "Hiking", "Swimming"],
                    icon: "figure.hiking"
                )
            } else if temperature < 15 {
                OutfitSuggestionCard(
                    title: "Indoor Activities",
                    items: ["Museum visit", "Coffee shop", "Movie night"],
                    icon: "house"
                )
            } else {
                OutfitSuggestionCard(
                    title: "Moderate Activities",
                    items: ["City walk", "Park visit", "Shopping"],
                    icon: "figure.walk"
                )
            }
        }
    }
}

struct OutfitSuggestionCard: View {
    let title: String
    let items: [String]
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.headline)
            }
            
            ForEach(items, id: \.self) { item in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(item)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
} 