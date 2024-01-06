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
                return Color(red: 1.0, green: 0.5, blue: 0.5) // Pastel Red
            case .orange:
                return Color(red: 1.0, green: 0.75, blue: 0.5) // Pastel Orange
            case .yellow:
                return Color(red: 1.0, green: 1.0, blue: 0.6) // Pastel Yellow
            case .lime:
                return Color(red: 0.85, green: 1.0, blue: 0.5) // Pastel Lime
            case .green:
                return Color(red: 0.5, green: 1.0, blue: 0.5) // Pastel Green
            }
        }

    }
}
