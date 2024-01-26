//
//  HomeView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import SwiftUI

struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var cards: [Card]
    
    @State private var showingShareSheet = false
    @State private var showingSettingsSheet = false
    
    var body: some View {
        NavigationView {
            List {
                if let lastCard = cards.last {
                    NavigationLink {
                        EditCardView(card: lastCard)
                    } label: {
                        CardView(card: lastCard)
                    }
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [CardColours.color(for: lastCard.score), CardColours.color(for: lastCard.score - 1)]), startPoint: .leading, endPoint: .trailing))
                }
                
                ForEach(cards.dropLast().reversed()) { card in
                    CardView(card: card)
                        .listRowSpacing(20)
                        .listRowBackground(LinearGradient(gradient: Gradient(colors: [CardColours.color(for: card.score), CardColours.color(for: card.score - 1)]), startPoint: .leading, endPoint: .trailing))
                        .padding(.vertical, 5)
                        .cornerRadius(9)
                        .opacity(0.5)
                }
            }
            .navigationTitle("Feelings Share")
            .toolbar {
                Button("Settings", systemImage: "gear"){
                    showingSettingsSheet = true
                }
                Button("Share todays's score", systemImage: "square.and.arrow.up"){
                    showingShareSheet = true
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    checkForNewCard()
                }
                
            }
            .sheet(isPresented: $showingShareSheet) {
                if let lastCard = cards.last {
                    //ShareView(itemsToShare: [lastCard.score])
                    ShareView(itemsToShare: ["Today I feel like a \(lastCard.score) \(CardDetails.emojiScale[lastCard.score - 1])."])
                }
            }
            .sheet(isPresented: $showingSettingsSheet) {
                SettingsView()
            }
        }
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .environment(\.modelContext, modelContext)
        .preferredColorScheme(.dark)
    }
    
    func share() {
        // Your share logic
    }
    
    func checkForNewCard() {
        if cards.isEmpty || !isToday(date: cards.last!.date) {
            addNewCard()
        }
    }
    
    func addNewCard() {
        let newCardDate = Calendar.current.startOfDay(for: Date())
        
        // Check if a card with the same date already exists
        let existingCard = cards.first { card in
            Calendar.current.isDate(card.date, inSameDayAs: newCardDate)
        }
        
        if existingCard == nil {
            let newCard = Card(date: newCardDate)
            print("addNewCard: \(newCard.date)")
            modelContext.insert(newCard)
        }
    }
    
    func isToday(date: Date) -> Bool {
        print("Date in to isToday \(date)")
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        return todayComponents == selectedDateComponents
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
