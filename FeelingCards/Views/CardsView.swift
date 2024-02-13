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
    
    @State private var showingSettingsSheet = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack (path: $path) {
            List {
                if let lastCard = cards.last {
                    
                    NavigationLink(value: lastCard) {
                        CardView(card: lastCard)
                    }
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
            .navigationTitle("Mood Mapping")
            .navigationDestination(for: Card.self) { card in
                ChooseScoreView(card: card)
            }
            
            //.navigationTitle("Map My Mood")
            .toolbar {
                Button("Settings", systemImage: "gear"){
                    showingSettingsSheet = true
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    checkForNewCard()
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
