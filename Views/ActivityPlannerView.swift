import SwiftUI
import EventKit

struct ActivityPlannerView: View {
    @EnvironmentObject var weatherService: WeatherService
    @StateObject private var calendarService = CalendarService()
    @State private var selectedDate = Date()
    @State private var showingCalendarAccessAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Date Picker
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                
                if let weather = weatherService.currentWeather {
                    // Weather Summary
                    WeatherSummaryView(weather: weather)
                        .padding()
                    
                    // Activity Suggestions
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
                            ForEach(calendarService.suggestActivities(for: weather, date: selectedDate)) { suggestion in
                                ActivitySuggestionCard(suggestion: suggestion)
                            }
                        }
                        .padding()
                    }
                } else {
                    Text("Enter a location to see activity suggestions")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .navigationTitle("Activity Planner")
            .onAppear {
                if !calendarService.calendarAccessGranted {
                    showingCalendarAccessAlert = true
                }
            }
            .alert("Calendar Access Required", isPresented: $showingCalendarAccessAlert) {
                Button("Grant Access") {
                    calendarService.requestCalendarAccess()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(Config.Calendar.calendarAccessMessage)
            }
        }
    }
}

struct WeatherSummaryView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(Int(weather.main.temp))°")
                .font(.system(size: 48, weight: .bold))
            Text(weather.weather.first?.description.capitalized ?? "")
                .font(.title3)
            HStack {
                Label("\(weather.main.humidity)%", systemImage: "humidity")
                Label("\(Int(weather.main.feelsLike))°", systemImage: "thermometer")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct ActivitySuggestionCard: View {
    let suggestion: ActivitySuggestion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: suggestion.icon)
                .font(.system(size: 30))
                .foregroundColor(.blue)
            
            Text(suggestion.title)
                .font(.headline)
            
            Text(suggestion.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
} 