//
//  AveragesView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftUI

struct AveragesView: View {
    @State private var selectedAverageTab: String = "Week"

    let scores = DataGenerator.scores

    var averageScore: Double {
        let totalScore = scores.reduce(0) { $0 + $1.score }
        return !scores.isEmpty ? Double(totalScore) / Double(scores.count) : 0
    }

    var body: some View {
        VStack {
            Spacer()
            
            Text("Average: \(averageScore, specifier: "%.1f")")
                .font(.title)
                .foregroundColor(.primary)

            Spacer()
            // Conditional View Rendering
            if selectedAverageTab == "Week" {
                WeekGraphView(scores: Array(scores.suffix(7)))
            } else if selectedAverageTab == "Month" {
                MonthGraphView(scores: Array(scores.suffix(31))) // Modify as needed
            } else if selectedAverageTab == "Year" {
                YearGraphView(scores: Array(scores.suffix(12))) // Modify as needed
            }
            Spacer()
            
            HStack {
                Button("Week") {
                    selectedAverageTab = "Week"
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedAverageTab == "Week"))
                .padding()
                .padding(.horizontal)

                Button("Month") {
                    selectedAverageTab = "Month"
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedAverageTab == "Month"))
                .padding()
                .padding(.horizontal)
                
                Button("Year") {
                    selectedAverageTab = "Year"
                }
                .buttonStyle(TabButtonStyle(isSelected: selectedAverageTab == "Year"))
                .padding()
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct TabButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .blue : .gray)
    }
}

struct WeekGraphView: View {
    let scores: [ScoreEntry]
    private let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(0..<scores.count, id: \.self) { index in
                VStack {
                    Text("\(scores[index].score)")
                        .font(.caption)

                    Rectangle()
                        .fill(Color.blue)
                        .frame(height: CGFloat(scores[index].score) * 20.0)

                    Text(daysOfWeek[index])
                        .font(.caption)
                }
            }
        }
        .padding()
        
    }
}


struct MonthGraphView: View {
    let scores: [ScoreEntry] // Array with 31 or fewer elements

    private var daysInMonth: Int {
        let calendar = Calendar.current
        let date = Date()
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 30
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 4) {
                ForEach(0..<daysInMonth, id: \.self) { day in
                    VStack {
                        // Assuming scores are ordered and correspond to each day
                        Text("\(scores[day].score)")
                            .font(.caption)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: CGFloat(scores[day].score) * 20.0)

                        Text("\(day + 1)")
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
}

struct YearGraphView: View {
    let scores: [ScoreEntry] // Array with 12 elements

    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    var body: some View {
            HStack(alignment: .bottom, spacing: 7) {
                ForEach(0..<12, id: \.self) { month in
                    VStack {
                        Text("\(scores[month].score)")
                            .font(.caption)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: CGFloat(scores[month].score) * 20.0)

                        Text(months[month])
                            .font(.caption)
                    }
                }
            }
            .padding()
        
    }
}


struct ScoreEntry {
    var score: Int
}

struct DataGenerator {
    static var scores: [ScoreEntry] {
        var generatedScores = [ScoreEntry]()
        for _ in 1...366 {
            generatedScores.append(ScoreEntry(score: Int.random(in: 3...9)))
        }
        return generatedScores
    }
}



#Preview("Light Mode") {
    AveragesView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    AveragesView()
        .preferredColorScheme(.dark)
}
