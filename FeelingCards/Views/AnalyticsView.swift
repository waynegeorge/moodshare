//
//  AnalyticsView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftUI
import Charts
import SwiftData

struct AnalyticsView: View {
    @Query var cards: [Card]
    @State private var selectedTab: String = "Week"
    
    //    var averageScore: Double {
    //        let validScores = cards.filter { $0.score > 0 }
    //        let totalScore = validScores.reduce(0) { $0 + $1.score }
    //        return !validScores.isEmpty ? Double(totalScore) / Double(validScores.count) : 0
    //    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                switch selectedTab {
                case "Week":
                    WeekGraphView(cards: cards)
                        .padding(.top, 30)
                case "Month":
                    MonthGraphView(cards: cards)
                        .padding(.top, 30)
                    //case "Year":
                    //YearGraphView(cards: cards)
                default:
                    Text("Select a valid time frame")
                }
                
                Picker("Chart View", selection: $selectedTab) {
                    Text("Last Week").tag("Week")
                    Text("Last Month").tag("Month")
                    //Text("Last Year").tag("Year")
                }
                .padding(.top, 20)
                .padding(.horizontal, 50)
                .pickerStyle(.segmented)
                
                Spacer()
            }
            .navigationTitle("Analytics")
        }
    }
}

struct WeekGraphView: View {
    let cards: [Card]
    
    var body: some View {
        VStack {
            Text("Average Score: \(averageScore, specifier: "%.1f")")
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.bottom, 30)
            
            Chart {
                ForEach(sortedLastSevenCards, id: \.id) { card in
                    if let weekday = Calendar.current.dateComponents([.weekday], from: card.date).weekday {
                        BarMark(x: .value("WeekDay", weekdayString(from: weekday)),
                                y: .value("Score", card.score))
                        .foregroundStyle(CardColours.color(for: card.score))
                    }
                }
            }
            .chartYScale(domain: 0...10)
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
    }
    
    private var sortedLastSevenCards: [Card] {
        return cards
            .sorted(by: { $0.date < $1.date }) // Sort by date in ascending order
            .suffix(7) // Take the last 7 items
    }
    
    func weekdayString(from weekday: Int) -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.shortWeekdaySymbols[weekday - 1]
    }
    
    private var averageScore: Double {
        let scores = sortedLastSevenCards.map { $0.score }
        guard !scores.isEmpty else { return 0 }
        let totalScore = scores.reduce(0, +)
        return Double(totalScore) / Double(scores.count)
    }
}

struct MonthGraphView: View {
    let cards: [Card]
    
    var body: some View {
        VStack {
            Text("Average Score: \(averageScore, specifier: "%.1f")")
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.bottom, 30)
            
            Chart {
                ForEach(sortedLastThirtyCards, id: \.id) { card in
                    BarMark(x: .value("Date", card.date, unit: .day),
                            y: .value("Score", card.score))
                    .foregroundStyle(CardColours.color(for: card.score))
                }
            }
            .chartYScale(domain: 0...10)
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
    }
    
    private var sortedLastThirtyCards: [Card] {
        return cards
            .sorted(by: { $0.date < $1.date }) // Sort by date in ascending order
            .suffix(30) // Take the last 30 items
    }
    
    private var averageScore: Double {
        let scores = sortedLastThirtyCards.map { $0.score }
        guard !scores.isEmpty else { return 0 }
        let totalScore = scores.reduce(0, +)
        return Double(totalScore) / Double(scores.count)
    }
}

//struct YearGraphView: View {
//    let cards: [Card]
//
//    var body: some View {
//        Chart {
//            ForEach(1...12, id: \.self) { month in
//                BarMark(
//                    x: .value("Month", monthString(from: month)),
//                    y: .value("Score", scoreForMonth(month))
//                )
//            }
//        }
//        .chartYScale(domain: 0...10)
//        .chartXScale(domain: 1...12)
//        .aspectRatio(1, contentMode: .fit)
//        .padding()
//    }
//
//    func monthString(from month: Int) -> String {
//        let dateFormatter = DateFormatter()
//        return dateFormatter.monthSymbols[month - 1]
//    }
//
//    func scoreForMonth(_ month: Int) -> Int {
//        let calendar = Calendar.current
//        let scoresForMonth = cards.filter {
//            calendar.component(.month, from: $0.date) == month && $0.score > 0
//        }.map { $0.score }
//        return scoresForMonth.isEmpty ? 0 : scoresForMonth.reduce(0, +) / scoresForMonth.count
//    }
//}
#Preview("Light Mode") {
    AnalyticsView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    AnalyticsView()
        .preferredColorScheme(.dark)
}
