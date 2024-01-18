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
        List {
            ForEach(cards) { card in
                CardView(card: card)
                    .listRowSpacing(20)
                    .listRowBackground(CardColours.color(for: card.score))
                    .padding(.vertical, 5)
                    .cornerRadius(9)
            }
        }
        .navigationTitle("Feeling Cards")
        .toolbar {
            Button("Add Samples", action: addSamples)
            
        }
    }
    func addSamples() {
        //let one = Card(score: 0)
        
        let two = Card(score: 6, words: [CardDetails.words[0], CardDetails.words[1], CardDetails.words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        let three = Card(score: 8, words: [CardDetails.words[0], CardDetails.words[1], CardDetails.words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        let four = Card(score: 4, words: [CardDetails.words[0], CardDetails.words[1], CardDetails.words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        let five = Card(score: 5, words: [CardDetails.words[0], CardDetails.words[1], CardDetails.words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        
        let six = Card(score: 2, words: [CardDetails.words[0], CardDetails.words[1], CardDetails.words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        //modelContext.insert(one)
        modelContext.insert(two)
        modelContext.insert(three)
        modelContext.insert(four)
        modelContext.insert(five)
        modelContext.insert(six)
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
