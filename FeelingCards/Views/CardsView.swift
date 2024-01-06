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
            //            List(cards, id: \.self) { card in
            //                CardView(card: card)
            //            }
        }
        .navigationDestination(for: Card.self, destination: CardView.init)
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



//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Card.self, configurations: config)
//
//        return CardsView()
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
