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
    
    var body: some View {
        NavigationView {
            List {
                if let firstCard = cards.first {
                    NavigationLink {
                        EditCardView(card: firstCard) // Pass the first card for editing
                    } label: {
                        CardView(card: firstCard) // Display the first card as the link label
                    }
                    .listRowBackground(CardColours.color(for: firstCard.score))
                }
                
                ForEach(cards.dropFirst()) { card in
                    CardView(card: card)
                        .listRowSpacing(20)
                        .listRowBackground(CardColours.color(for: card.score))
                        .padding(.vertical, 5)
                        .cornerRadius(9)
                }
            }
            .navigationTitle("Feelings Share")
            .toolbar {
                Button("Share", systemImage: "square.and.arrow.up", action: share)
                
            }
            .onAppear {  // Move card checking and creation logic here
                checkForNewCard()
            }
        }
        .environment(\.modelContext, modelContext)
    }
    
    func share() {
        
    }
    
    func checkForNewCard() {
        if let latestCard = cards.sorted(by: { $0.date > $1.date }).first {
            if !Calendar.current.isDateInToday(latestCard.date) {
                addNewCard()
            }
        } else {
            addNewCard() // For new install
        }
    }
    
    func addNewCard() {
        let newCard = Card()
        modelContext.insert(newCard)
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
