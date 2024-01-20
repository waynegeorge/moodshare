//
//  ShareView.swift
//  FeelingCards
//
//  Created by Wayne George on 20/01/2024.
//

import SwiftData
import SwiftUI

struct ShareView: View {
    @Bindable var card : Card
    
    var body: some View {
        Text("Share")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let words = CardDetails.words
        let example1 = Card(score: 0)
        let example2 = Card(score: 2, words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        return ShareView(card: example1)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}

