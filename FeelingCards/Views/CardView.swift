//
//  CardView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import SwiftUI

struct CardView: View {
    var card : Card
    
    var body: some View {
        VStack {
            Text(DateUtility.formattedDate(Date.now))
                .frame(width: 200)
            
            if (card.score >= 1 && card.score <= 10) {
                Text("Your score is \(card.score)")
                    .padding()
                    .font(.title2)
            } else {
                Text("Tap to give your score for today")
                    .padding()
                    .font(.title2)
            }
            
            if (card.toShare != "") {
                VStack {
                    Text("Reason for your score:")
                        .bold()
                    Text(card.toShare)
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            
            if (card.words.count != 0) {
                VStack {
                    Text("Words: ")
                        .bold()
                    Text(card.words.joined(separator: ", ") )
                        .italic()
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            
            if (card.positives != "") {
                VStack {
                    Text("Positives of the day:")
                        .bold()
                    Text(card.positives)
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
            
            if (card.liked != "") {
                VStack {
                    Text("Liked about yourself today:")
                        .bold()
                    Text(card.liked)
                }
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
        }
        .frame(minWidth: 100, minHeight: 200)
        
        .padding()
        .background(CardColours.color(for: card.score))
        .cornerRadius(10)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let words = WordList.words
        let example = Card(words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        return CardView(card: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
