//
//  HomeView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import SwiftUI

enum ViewDestination: Hashable {
    case chooseScore
    case chooseWords
    case chooseReason
}

struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var cards: [Card]
    
    @State private var showingSettingsSheet = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                if let lastCard = cards.last {
                    CardView(card: lastCard)
                        .onTapGesture {
                            navigationPath.append(ViewDestination.chooseScore)
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
            .navigationDestination(for: ViewDestination.self) { destination in
                if let lastCard = cards.last
                {
                    switch destination {
                    case .chooseScore:
                        ChooseScoreView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseWords:
                        ChooseWordsView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseReason:
                        ChooseReasonView(navigationPath: $navigationPath, card: lastCard)
                    }
                }
            }
            .onAppear {
                checkForNewCard()
            }
            .navigationTitle("Map My Mood")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingSettingsSheet = true }) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingSettingsSheet) {
                SettingsView() // Adjust as per your actual implementation
            }
        }
        .environment(\.modelContext, modelContext)
        .preferredColorScheme(.dark)
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
