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
    @State public var shareItems: [Any] = []
    @State private var showingShareSheet = false
    @State private var showingHelpSheet = false
    
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
                    Text("Past 7 days").tag("Week")
                    Text("Past 30 days").tag("Month")
                    //Text("Last Year").tag("Year")
                }
                .padding(.vertical, 21)
                .padding(.horizontal, 50)
                .pickerStyle(.segmented)
                
                HStack {
                    Button {
                        captureAndPrepareShare()
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                    }
                    //                    Button {
                    //                        shareItems = ["Hello World!"]
                    //                        showingShareSheet = true
                    //                    } label: {
                    //                        Label("Test", systemImage: "square.and.arrow.up")
                    //                            .foregroundColor(.white)
                    //                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                    //                            .background(
                    //                                RoundedRectangle(cornerRadius: 10)
                    //                                    .fill(Color.red)
                    //                            )
                    //                    }
                }
                
                Spacer()
            }
            .sheet(isPresented: $showingShareSheet) {
                ShareView(itemsToShare: shareItems)
            }
            .sheet(isPresented: $showingHelpSheet) {
                let helpText = "Analytics"
                HelpView(helpText: helpText)
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingHelpSheet = true
            }) {
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            )
            .navigationTitle("Analytics")
        }
    }
    
    private func captureAndPrepareShare() {
        if let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .filter({ $0.isKeyWindow }).first {
            
            let screenshot = windowScene.rootViewController?.view.takeScreenshot()
            
            let scale = UIScreen.main.scale
            let cropY = (screenshot?.size.height ?? 0) * 0.1
            let cropHeight = (screenshot?.size.height ?? 0) * 0.74
            let cropRect = CGRect(x: 0, y: cropY * scale, width: (screenshot?.size.width ?? 0) * scale, height: cropHeight * scale)
            
            if let croppedImage = screenshot?.cropped(to: cropRect),
               let imageData = croppedImage.jpegData(compressionQuality: 0.8) {
                shareItems = [imageData]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showingShareSheet = true
                }
                
                print("Image ready for sharing")
            } else {
                print("Failed to prepare image data")
            }
        } else {
            print("No key window found")
        }
    }
}

struct WeekGraphView: View {
    let cards: [Card]
    
    var body: some View {
        VStack {
            Text("Average Mood: \(averageScore, specifier: "%.1f")")
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.bottom, 30)
            
            Chart {
                ForEach(weekData, id: \.weekday) { data in
                    BarMark(x: .value("WeekDay", weekdayString(from: data.weekday)),
                            y: .value("Score", data.score))
                    .foregroundStyle(CardColours.color(for: data.score))
                }
            }
            .chartYScale(domain: 0...10)
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
    }
    
    private var weekData: [WeekData] {
        var data = [WeekData]()
        let calendar = Calendar.current
        let today = Date()
        
        let lastSevenCards = sortedLastSevenCards
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let weekday = calendar.component(.weekday, from: date)
                let score = lastSevenCards.first(where: { calendar.isDate($0.date, inSameDayAs: date) })?.score ?? 0
                data.append(WeekData(weekday: weekday, score: score))
            }
        }
        
        return data.reversed()
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
    
    struct WeekData {
        let weekday: Int
        let score: Int
    }
}

struct MonthGraphView: View {
    let cards: [Card]
    
    var body: some View {
        VStack {
            Text("Average Mood: \(averageScore, specifier: "%.1f")")
                .font(.title3)
                .foregroundColor(.primary)
                .padding(.bottom, 30)
            
            Chart {
                ForEach(monthData, id: \.date) { data in
                    BarMark(x: .value("Date", data.date, unit: .day),
                            y: .value("Score", data.score))
                    .foregroundStyle(CardColours.color(for: data.score))
                }
            }
            .chartYScale(domain: 0...10)
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }
    }
    
    private var monthData: [DayData] {
        var data = [DayData]()
        let calendar = Calendar.current
        let today = Date()
        
        let lastThirtyCards = sortedLastThirtyCards
        
        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                let score = lastThirtyCards.first(where: { calendar.isDate($0.date, inSameDayAs: date) })?.score ?? 0
                data.append(DayData(date: date, score: score))
            }
        }
        
        return data.reversed()
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
    
    struct DayData {
        let date: Date
        let score: Int
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
