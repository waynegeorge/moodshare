//
//  Previewer.swift
//  FeelingCards
//
//  Created by Wayne George on 10/01/2024.
//

import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let card: Card
    let words = CardDetails.words

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Card.self, configurations: config)

        card = Card(score: 0, words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        
        container.mainContext.insert(card)
    }
}
