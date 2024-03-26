//
//  CardColours.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI

struct CardColours {
    static func color(for value: Int) -> Color {
        guard value >= 1, value <= 10 else {
            return Color(red: 0.9, green: 0.9, blue: 0.9) // Default Grey
        }

        // Define color steps from red to green
        switch value {
        case 1:
            return Color(red: 1.0, green: 0.8, blue: 0.8) // Pastel Red
        case 2:
            return Color(red: 1.0, green: 0.9, blue: 0.8) // Pastel Orange-Red
        case 3:
            return Color(red: 1.0, green: 0.95, blue: 0.8) // Lighter Pastel Orange
        case 4:
            return Color(red: 1.0, green: 1.0, blue: 0.8) // Pastel Yellow-Orange
        case 5:
            return Color(red: 1.0, green: 1.0, blue: 0.6) // Pastel Yellow
        case 6:
            return Color(red: 0.8, green: 1.0, blue: 0.8) // Pastel Green-Yellow
        case 7:
            return Color(red: 0.7, green: 1.0, blue: 0.7) // Light Pastel Green
        case 8:
            return Color(red: 0.6, green: 1.0, blue: 0.6) // Pastel Green
        case 9:
            return Color(red: 0.6, green: 1.0, blue: 0.8) // Pastel Green-Blue
        case 10:
            return Color(red: 0.6, green: 1.0, blue: 1.0) // Pastel Green-Cyan
        default:
            return Color(red: 0.9, green: 0.9, blue: 0.9) // Fallback to Grey
        }
    }
}
