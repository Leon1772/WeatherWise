import SwiftUI

struct BadgesView: View {
    @State private var badges: [Badge] = [
        Badge(
            id: "rain_streak",
            title: "Rain Lover",
            description: "Experienced 3 consecutive days of rain",
            icon: "cloud.rain.fill",
            isEarned: false
        ),
        Badge(
            id: "temperature_extreme",
            title: "Temperature Warrior",
            description: "Survived extreme temperatures",
            icon: "thermometer.sun.fill",
            isEarned: false
        ),
        Badge(
            id: "weather_variety",
            title: "Weather Explorer",
            description: "Experienced 5 different weather types",
            icon: "cloud.sun.fill",
            isEarned: false
        ),
        Badge(
            id: "sunny_days",
            title: "Sun Seeker",
            description: "Enjoyed 7 sunny days",
            icon: "sun.max.fill",
            isEarned: false
        ),
        Badge(
            id: "snow_expert",
            title: "Snow Expert",
            description: "Experienced snowfall",
            icon: "snow",
            isEarned: false
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(badges) { badge in
                        BadgeCard(badge: badge)
                    }
                }
                .padding()
            }
            .navigationTitle("Badges")
        }
    }
}

struct Badge: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    var isEarned: Bool
}

struct BadgeCard: View {
    let badge: Badge
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(badge.isEarned ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                
                Image(systemName: badge.icon)
                    .font(.system(size: 40))
                    .foregroundColor(badge.isEarned ? .white : .gray)
            }
            
            Text(badge.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(badge.description)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            if !badge.isEarned {
                Text("Locked")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
        .opacity(badge.isEarned ? 1 : 0.7)
    }
} 