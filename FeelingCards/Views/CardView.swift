//
//  CardView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import SwiftUI

struct CardView: View {
    @Bindable var card : Card
    
    var body: some View {
        VStack {
            HStack {
                Text(DateUtility.formattedDate(card.date))
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 200, height: 30)
                    .border(Color.black, width: 2)
            }
            
            Group {
                if card.score >= 1 && card.score <= 10 {
                    Text(CardDetails.emojiScale[card.score - 1])
                        .font(.system(size: 120))
                    Text(Calendar.current.isDateInToday(card.date) ?
                         "Today your score is \(card.score)" :
                            "Your score was \(card.score)")
                } else if Calendar.current.isDateInToday(card.date) {
                    Text("Tap to give your score for today")
                } else {
                    Text("No score given")
                }
            }
            .padding()
            .font(.title2)
            .foregroundColor(.black)
            
            if (card.toShare != "") {
                VStack {
                    Text("Reason for your score:")
                        .bold()
                    Text(card.toShare)
                }
                .frame(minWidth: 0, maxWidth: 300)
                .padding(.horizontal, 10)
                .padding(.vertical)
                .foregroundColor(.black)
            }
            
            if (card.words.count != 0) {
                VStack {
                    Text("Words: ")
                        .bold()
                    Text(card.words.joined(separator: ", ") )
                        .italic()
                }
                .frame(minWidth: 0, maxWidth: 300)
                .padding(.horizontal, 10)
                .padding(.vertical)
            }
        }
        .padding()
        .background(CardColours.color(for: card.score))
        .foregroundColor(.black)
        .cornerRadius(20.2)
        .frame(width: 400, height: 570)
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let words = CardDetails.words
        let example1 = Card(score: 0)
        let example2 = Card(score: 8, words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        return CardView(card: example2)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
