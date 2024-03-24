//
//  HomeView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftData
import SwiftUI

enum ViewDestination: Hashable {
    case chooseScore
    case chooseWords
    case chooseReason
}

struct CardsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var cards: [Card]
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                if let lastCard = cards.last {
                    CardView(card: lastCard)
                        .onTapGesture {
                            navigationPath.append(ViewDestination.chooseScore)
                        }
                        .background(backgroundForLastCard())
                }
            }
            .background(backgroundForLastCard())
            .navigationDestination(for: ViewDestination.self) { destination in
                if let lastCard = cards.last
                {
                    switch destination {
                    case .chooseScore:
                        ChooseScoreView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseWords:
                        ChooseWordsView(navigationPath: $navigationPath, card: lastCard)
                    case .chooseReason:
                        ChooseReasonView(navigationPath: $navigationPath, card: lastCard)
                    }
                }
            }
            .onAppear {
                checkForNewCard()
            }
            .navigationTitle("Map My Mood")
        }
        .ignoresSafeArea()
        .environment(\.modelContext, modelContext)
        .preferredColorScheme(.dark)
    }

    private func backgroundForLastCard() -> some View {
        let imageName = cards.last.map { "Group \($0.score)" } ?? "defaultBackground"
        return Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    func checkForNewCard() {
        if cards.isEmpty || !isToday(date: cards.last!.date) {
            addNewCard()
        }
    }
    
    func addNewCard() {
        let newCardDate = Calendar.current.startOfDay(for: Date())
        
        // Check if a card with the same date already exists
        let existingCard = cards.first { card in
            Calendar.current.isDate(card.date, inSameDayAs: newCardDate)
        }
        
        if existingCard == nil {
            let newCard = Card(date: newCardDate)
            print("addNewCard: \(newCard.date)")
            modelContext.insert(newCard)
        }
    }
    
    func isToday(date: Date) -> Bool {
        print("Date in to isToday \(date)")
        let calendar = Calendar.current
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        return todayComponents == selectedDateComponents
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
