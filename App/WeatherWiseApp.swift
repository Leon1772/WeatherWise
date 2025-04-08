import SwiftUI

@main
struct WeatherWiseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    
    var body: some View {
        TabView {
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun.fill")
                }
            
            ActivityPlannerView()
                .tabItem {
                    Label("Activities", systemImage: "calendar")
                }
            
            WeatherAlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "exclamationmark.triangle.fill")
                }
            
            OutfitView()
                .tabItem {
                    Label("Outfit", systemImage: "tshirt.fill")
                }
            
            QuotesView()
                .tabItem {
                    Label("Quotes", systemImage: "quote.bubble.fill")
                }
            
            BadgesView()
                .tabItem {
                    Label("Badges", systemImage: "trophy.fill")
                }
        }
        .environmentObject(weatherService)
    }
} 