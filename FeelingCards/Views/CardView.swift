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
    @State private var width: CGFloat = 400
    @State private var height: CGFloat = 570
    
    var body: some View {
        VStack {
            HStack {
                Text(DateUtility.formattedDate(card.date))
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 230, height: 30)
                    .border(Color.black, width: 2)
            }
            
            Group {
                if card.score >= 1 && card.score <= 10 {
                    Text(CardDetails.emojiScale[card.score - 1])
                        .font(.system(size: 120))
                    HStack {
                        Text(Calendar.current.isDateInToday(card.date) ?
                             "My mood today is:" :
                                "My mood was:")
                        Text("\(card.score)")
                            .font(.title)
                    }
                } else if Calendar.current.isDateInToday(card.date) {
                    Text("Tap to log mood for today")
                } else {
                    Text("No mood logged")
                }
            }
            .padding(.horizontal, 10)
            .font(.title2)
            .foregroundColor(.black)
            
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
            
            if (card.toShare != "") {
                VStack {
                    Text("Reason for my score:")
                        .bold()
                    Text(card.toShare)
                }
                .frame(minWidth: 0, maxWidth: 300)
                .padding(.horizontal, 10)
                .padding(.vertical)
                .foregroundColor(.black)
            }
        }
        .padding()
        .background(CardColours.color(for: card.score, opacity: 0.75))
        .foregroundColor(.black)
        .cornerRadius(20.2)
        .frame(width: width, height: height)
        .onAppear() {
            // for iphone SE
            let screenWidth = UIScreen.main.bounds.width
            if screenWidth < 390 {
                height = 300
            }
        }
    }
}
