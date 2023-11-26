//
//  CardColours.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI

struct CardColours {
    static func color(for value: Int) -> Color {
        guard value >= 1, value <= 10 else { return .gray }

        let index = (value - 1) / 2
        return CardColor.allCases[index].color
    }

    enum CardColor: Int, CaseIterable {
        case red, orange, yellow, lime, green

        var color: Color {
            switch self {
            case .red:
                return Color(red: 1.0, green: 0.0, blue: 0.0) // Red
            case .orange:
                return Color(red: 1.0, green: 0.65, blue: 0.0) // Orange
            case .yellow:
                return Color(red: 1.0, green: 1.0, blue: 0.0) // Yellow
            case .lime:
                return Color(red: 0.75, green: 1.0, blue: 0.0) // Lime Green
            case .green:
                return Color(red: 0.0, green: 1.0, blue: 0.0) // Green
            }
        }
    }
}
