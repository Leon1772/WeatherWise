import Foundation
import Combine

class WeatherAlertsService: ObservableObject {
    @Published var alerts: [WeatherAlert] = []
    @Published var healthRecommendations: [HealthRecommendation] = []
    
    func updateAlerts(for weather: Weather) {
        var newAlerts: [WeatherAlert] = []
        var newRecommendations: [HealthRecommendation] = []
        
        // UV Index Alert (assuming clear skies)
        if weather.weather.first?.main.lowercased() == "clear" {
            newAlerts.append(WeatherAlert(
                type: .uv,
                message: "High UV Index - Consider sunscreen protection",
                severity: .moderate
            ))
            newRecommendations.append(HealthRecommendation(
                type: .skinCare,
                message: "Apply SPF 30+ sunscreen every 2 hours",
                icon: "sun.max.fill"
            ))
        }
        
        // Temperature-based alerts
        if weather.main.temp > 30 {
            newAlerts.append(WeatherAlert(
                type: .temperature,
                message: "High Temperature Alert - Stay hydrated",
                severity: .high
            ))
            newRecommendations.append(HealthRecommendation(
                type: .hydration,
                message: "Drink at least 2L of water today",
                icon: "drop.fill"
            ))
        } else if weather.main.temp < 10 {
            newAlerts.append(WeatherAlert(
                type: .temperature,
                message: "Low Temperature Alert - Dress warmly",
                severity: .moderate
            ))
            newRecommendations.append(HealthRecommendation(
                type: .clothing,
                message: "Wear multiple layers and cover extremities",
                icon: "thermometer.snowflake"
            ))
        }
        
        // Humidity-based alerts
        if weather.main.humidity > 80 {
            newAlerts.append(WeatherAlert(
                type: .humidity,
                message: "High Humidity - May affect breathing",
                severity: .low
            ))
            newRecommendations.append(HealthRecommendation(
                type: .respiratory,
                message: "Consider indoor activities if you have respiratory conditions",
                icon: "lungs.fill"
            ))
        }
        
        // Rain alerts
        if weather.weather.first?.main.lowercased() == "rain" {
            newAlerts.append(WeatherAlert(
                type: .precipitation,
                message: "Rain Alert - Slippery conditions",
                severity: .moderate
            ))
            newRecommendations.append(HealthRecommendation(
                type: .safety,
                message: "Use caution when walking or driving",
                icon: "exclamationmark.triangle.fill"
            ))
        }
        
        // Update published properties
        DispatchQueue.main.async {
            self.alerts = newAlerts
            self.healthRecommendations = newRecommendations
        }
    }
}

struct WeatherAlert: Identifiable {
    let id = UUID()
    let type: AlertType
    let message: String
    let severity: AlertSeverity
}

struct HealthRecommendation: Identifiable {
    let id = UUID()
    let type: RecommendationType
    let message: String
    let icon: String
}

enum AlertType {
    case temperature
    case uv
    case humidity
    case precipitation
    case airQuality
}

enum AlertSeverity {
    case low
    case moderate
    case high
    case critical
}

enum RecommendationType {
    case hydration
    case skinCare
    case clothing
    case respiratory
    case safety
    case exercise
} 