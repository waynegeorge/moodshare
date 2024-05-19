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
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2024, month: 1, day: 1)
        let endComponents = DateComponents(year: 2049, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    //TODO remove
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    in: dateRange,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
            .padding(.bottom, 10)
            .frame(width: 324)
            .foregroundColor(.black)
            .cornerRadius(9)
            .navigationTitle("Archive")
            
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
                        
                        Text(selectedCard.words.count != 0 || selectedCard.toShare != "" ? "Tap for more" : "")
                            .frame(height: 15)
                        
                    } else {
                        Text("Nothing logged today yet")
                            .foregroundColor(.black)
                    }
                } else {
                    Text("No log available for this date")
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
                        currentCard = Card(date: date)
                    }
                } else {
                    colour = .gray
                    currentCard = Card(date: date)
                }
            }
            .sheet(isPresented: $showingCard) {
                CardView(card: currentCard)
            }
            .onTapGesture {
                if (currentCard.words.count != 0 || currentCard.toShare != "") {
                    showingCard.toggle()
                }
            }
            
//            Button("Add card") {
//                let newCard = Card(date: date, score: Int.random(in: 1...10))
//                modelContext.insert(newCard)
//            }
            
            Spacer()
        }
    }
}

#Preview {
    HistoryView()
}
