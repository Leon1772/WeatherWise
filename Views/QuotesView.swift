import SwiftUI

struct QuotesView: View {
    @State private var currentQuote: Quote?
    @State private var isAnimating = false
    
    let quotes: [Quote] = [
        Quote(text: "The best thing one can do when it's raining is to let it rain.", author: "Henry Wadsworth Longfellow"),
        Quote(text: "Sunshine is delicious, rain is refreshing, wind braces us up, snow is exhilarating; there is really no such thing as bad weather, only different kinds of good weather.", author: "John Ruskin"),
        Quote(text: "Wherever you go, no matter what the weather, always bring your own sunshine.", author: "Anthony J. D'Angelo"),
        Quote(text: "Life isn't about waiting for the storm to pass. It's about learning to dance in the rain.", author: "Vivian Greene"),
        Quote(text: "The sun does not shine for a few trees and flowers, but for the wide world's joy.", author: "Henry Ward Beecher"),
        Quote(text: "Clouds come floating into my life, no longer to carry rain or usher storm, but to add color to my sunset sky.", author: "Rabindranath Tagore"),
        Quote(text: "A rainy day is the perfect time for a walk in the woods.", author: "Rachel Carson"),
        Quote(text: "The sound of rain needs no translation.", author: "Alan Watts"),
        Quote(text: "Sunshine is a welcome thing. It brings a lot of brightness.", author: "Jimmie Davis"),
        Quote(text: "After a storm comes a calm.", author: "Matthew Henry")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if let quote = currentQuote {
                    QuoteCard(quote: quote, isAnimating: $isAnimating)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                isAnimating.toggle()
                            }
                        }
                }
                
                Button(action: {
                    withAnimation {
                        currentQuote = quotes.randomElement()
                        isAnimating = true
                    }
                }) {
                    Text("New Quote")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Weather Quotes")
            .onAppear {
                currentQuote = quotes.randomElement()
            }
        }
    }
}

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let author: String
}

struct QuoteCard: View {
    let quote: Quote
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text(quote.text)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
                .rotation3DEffect(
                    .degrees(isAnimating ? 360 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isAnimating)
            
            Text("- \(quote.author)")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeIn(duration: 0.5).delay(0.3), value: isAnimating)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
    }
} 