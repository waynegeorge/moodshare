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
            return Color(red: 1.0, green: 0.0, blue: 0.0) // Full Red
        case 2:
            return Color(red: 1.0, green: 0.2, blue: 0.0) // Lesser Red
        case 3:
            return Color(red: 1.0, green: 0.4, blue: 0.0) // Reddish Orange
        case 4:
            return Color(red: 1.0, green: 0.6, blue: 0.0) // Orange
        case 5:
            return Color(red: 1.0, green: 0.8, blue: 0.0) // Yellowish Orange
        case 6:
            return Color(red: 1.0, green: 1.0, blue: 0.0) // Yellow
        case 7:
            return Color(red: 0.8, green: 1.0, blue: 0.0) // Lime Green
        case 8:
            return Color(red: 0.6, green: 1.0, blue: 0.0) // Light Green
        case 9:
            return Color(red: 0.4, green: 1.0, blue: 0.0) // Greenish
        case 10:
            return Color(red: 0.0, green: 1.0, blue: 0.0) // Full Green
        default:
            return Color(red: 0.9, green: 0.9, blue: 0.9) // Fallback to Grey
        }
    }
}
