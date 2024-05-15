//
//  HistoryView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query var cards: [Card]
    @State private var date = Date()
    @State var colour: Color = .gray
    @State var showingCard = false
    @State var currentCard = Card()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
            .padding(.bottom, 10)
            .frame(width: 324)
            .foregroundColor(.black)
            .cornerRadius(9)
            .navigationTitle("History")
            
            VStack {
                if let selectedCard = cards.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                    if selectedCard.score >= 1 && selectedCard.score <= 10 {
                        Text(CardDetails.emojiScale[selectedCard.score - 1])
                            .font(.system(size: 80))
                        HStack {
                            Text(Calendar.current.isDateInToday(selectedCard.date) ?
                                 "My mood today is:" :
                                    "My mood was:")
                            Text("\(selectedCard.score)")
                                .font(.title)
                        }
                    }
                } else {
                    Text("No card available for this date")
                        .foregroundColor(.black)
                }
            }
            .frame(width: 300, height: 200)
            .background(colour)
            .foregroundColor(.black)
            .cornerRadius(20.2)
            .onAppear {
                if let selectedCard = cards.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                    if selectedCard.score >= 1 && selectedCard.score <= 10 {
                        colour = CardColours.color(for: selectedCard.score)
                        currentCard = selectedCard
                    }
                }
            }
            .onChange(of: date) { oldDate, newDate in
                if let selectedCard = cards.first(where: { Calendar.current.isDate($0.date, inSameDayAs: newDate) }) {
                    if selectedCard.score >= 1 && selectedCard.score <= 10 {
                        colour = CardColours.color(for: selectedCard.score)
                        currentCard = selectedCard
                    } else {
                        colour = .gray
                    }
                } else {
                    colour = .gray
                }
            }
            .sheet(isPresented: $showingCard) {
                CardView(card: currentCard)
            }
            .onTapGesture {
                showingCard.toggle()
            }
            
            Spacer()
        }
    }
}

#Preview {
    HistoryView()
}
