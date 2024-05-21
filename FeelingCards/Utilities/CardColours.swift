//
//  CardColours.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI

struct CardColours {
    static func color(for value: Int, opacity: Double = 1.0) -> Color {
        let baseColor: Color
        guard value >= 1, value <= 10 else {
            baseColor = Color(red: 0.9, green: 0.9, blue: 0.9) // Default Grey
            return baseColor.opacity(opacity)
        }
        
        switch value {
        case 1:
            baseColor = Color(red: 1.00, green: 0.00, blue: 0.00) // Color 1
        case 2:
            baseColor = Color(red: 0.88, green: 0.31, blue: 0.34) // Color 2
        case 3:
            baseColor = Color(red: 0.78, green: 0.63, blue: 0.50) // Color 3
        case 4:
            baseColor = Color(red: 0.58, green: 0.68, blue: 0.50) // Color 4
        case 5:
            baseColor = Color(red: 0.58, green: 0.68, blue: 1.00) // Color 5
        case 6:
            baseColor = Color(red: 0.00, green: 0.83, blue: 1.00) // Color 6
        case 7:
            baseColor = Color(red: 0.00, green: 1.00, blue: 1.00) // Color 7
        case 8:
            baseColor = Color(red: 0.00, green: 1.00, blue: 0.80) // Color 8
        case 9:
            baseColor = Color(red: 0.00, green: 1.00, blue: 0.50) // Color 9
        case 10:
            baseColor = Color(red: 0.00, green: 1.00, blue: 0.00) // Color 10
        default:
            baseColor = Color(red: 0.9, green: 0.9, blue: 0.9) // Fallback to Grey
        }
        return baseColor.opacity(opacity)
    }
}

