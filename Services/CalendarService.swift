import Foundation
import EventKit
import Combine

class CalendarService: ObservableObject {
    @Published var events: [EKEvent] = []
    @Published var calendarAccessGranted = false
    @Published var errorMessage: String?
    
    private let eventStore = EKEventStore()
    private var cancellables = Set<AnyCancellable>()
    
    func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.calendarAccessGranted = granted
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                }
                if granted {
                    self?.fetchEvents()
                }
            }
        }
    }
    
    func fetchEvents() {
        let calendars = eventStore.calendars(for: .event)
        let oneMonthAgo = Date().addingTimeInterval(-30*24*60*60)
        let oneMonthFromNow = Date().addingTimeInterval(30*24*60*60)
        
        let predicate = eventStore.predicateForEvents(withStart: oneMonthAgo, end: oneMonthFromNow, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        
        DispatchQueue.main.async {
            self.events = events
        }
    }
    
    func suggestActivities(for weather: Weather, date: Date) -> [ActivitySuggestion] {
        var suggestions: [ActivitySuggestion] = []
        
        // Get events for the specific date
        let dayEvents = events.filter { Calendar.current.isDate($0.startDate, inSameDayAs: date) }
        
        // Base suggestions on weather conditions
        if let weatherCondition = weather.weather.first?.main.lowercased() {
            switch weatherCondition {
            case "clear":
                suggestions.append(contentsOf: [
                    ActivitySuggestion(title: "Outdoor Sports", description: "Perfect day for outdoor activities", icon: "figure.run"),
                    ActivitySuggestion(title: "Picnic", description: "Enjoy a meal outdoors", icon: "basket.fill"),
                    ActivitySuggestion(title: "Gardening", description: "Great weather for gardening", icon: "leaf.fill")
                ])
            case "rain":
                suggestions.append(contentsOf: [
                    ActivitySuggestion(title: "Indoor Games", description: "Stay dry with indoor activities", icon: "gamecontroller.fill"),
                    ActivitySuggestion(title: "Movie Night", description: "Perfect weather for a movie", icon: "film.fill"),
                    ActivitySuggestion(title: "Reading", description: "Cozy up with a good book", icon: "book.fill")
                ])
            case "clouds":
                suggestions.append(contentsOf: [
                    ActivitySuggestion(title: "Museum Visit", description: "Good day for indoor exploration", icon: "building.columns.fill"),
                    ActivitySuggestion(title: "Shopping", description: "Explore local shops", icon: "bag.fill"),
                    ActivitySuggestion(title: "Café Visit", description: "Enjoy a warm drink", icon: "cup.and.saucer.fill")
                ])
            default:
                suggestions.append(contentsOf: [
                    ActivitySuggestion(title: "Local Events", description: "Check out what's happening nearby", icon: "calendar"),
                    ActivitySuggestion(title: "Exercise", description: "Stay active indoors or outdoors", icon: "figure.walk"),
                    ActivitySuggestion(title: "Relaxation", description: "Take time to unwind", icon: "bed.double.fill")
                ])
            }
        }
        
        // Adjust suggestions based on temperature
        if weather.main.temp < 10 {
            suggestions = suggestions.filter { $0.title != "Outdoor Sports" && $0.title != "Picnic" }
            suggestions.append(ActivitySuggestion(title: "Hot Chocolate", description: "Warm up with a hot drink", icon: "mug.fill"))
        }
        
        // Add calendar-specific suggestions
        if !dayEvents.isEmpty {
            suggestions.append(ActivitySuggestion(
                title: "Calendar Events",
                description: "You have \(dayEvents.count) events scheduled",
                icon: "calendar.badge.clock"
            ))
        }
        
        return suggestions
    }
}

struct ActivitySuggestion: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
} 