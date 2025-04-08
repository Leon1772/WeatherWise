import SwiftUI

struct WeatherAlertsView: View {
    @EnvironmentObject var weatherService: WeatherService
    @StateObject private var alertsService = WeatherAlertsService()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let weather = weatherService.currentWeather {
                        // Active Alerts Section
                        if !alertsService.alerts.isEmpty {
                            SectionView(title: "Active Alerts", systemImage: "exclamationmark.triangle.fill") {
                                ForEach(alertsService.alerts) { alert in
                                    AlertCard(alert: alert)
                                }
                            }
                        }
                        
                        // Health Recommendations Section
                        if !alertsService.healthRecommendations.isEmpty {
                            SectionView(title: "Health Recommendations", systemImage: "heart.fill") {
                                ForEach(alertsService.healthRecommendations) { recommendation in
                                    RecommendationCard(recommendation: recommendation)
                                }
                            }
                        }
                    } else {
                        Text("Enter a location to see weather alerts and recommendations")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Weather Alerts")
            .onChange(of: weatherService.currentWeather) { newWeather in
                if let weather = newWeather {
                    alertsService.updateAlerts(for: weather)
                }
            }
        }
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let systemImage: String
    let content: Content
    
    init(title: String, systemImage: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title, systemImage: systemImage)
                .font(.title2)
                .foregroundColor(.primary)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct AlertCard: View {
    let alert: WeatherAlert
    
    var severityColor: Color {
        switch alert.severity {
        case .low: return .blue
        case .moderate: return .yellow
        case .high: return .orange
        case .critical: return .red
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(severityColor)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(alert.message)
                    .font(.headline)
                
                Text(alert.type.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct RecommendationCard: View {
    let recommendation: HealthRecommendation
    
    var body: some View {
        HStack {
            Image(systemName: recommendation.icon)
                .foregroundColor(.blue)
                .font(.title2)
            
            Text(recommendation.message)
                .font(.subheadline)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// Extension to make AlertType conform to RawRepresentable for display
extension AlertType: RawRepresentable {
    typealias RawValue = String
    
    init?(rawValue: String) {
        switch rawValue {
        case "temperature": self = .temperature
        case "uv": self = .uv
        case "humidity": self = .humidity
        case "precipitation": self = .precipitation
        case "airQuality": self = .airQuality
        default: return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .temperature: return "temperature"
        case .uv: return "uv"
        case .humidity: return "humidity"
        case .precipitation: return "precipitation"
        case .airQuality: return "airQuality"
        }
    }
} 