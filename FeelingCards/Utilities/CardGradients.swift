//
//  CardGradients.swift
//  FeelingCards
//
//  Created by Wayne George on 17/02/2024.
//

import SwiftUI

struct CardGradients {
    static func gradient(for value: Int) -> LinearGradient {
        let startPoint: UnitPoint = .leading
        let endPoint: UnitPoint = .trailing
        switch value {
        case 1:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.0, blue: 0.0), Color(red: 1.0, green: 0.2, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 2:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.2, blue: 0.0), Color(red: 1.0, green: 0.4, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 3:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.4, blue: 0.0), Color(red: 1.0, green: 0.6, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 4:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.6, blue: 0.0), Color(red: 1.0, green: 0.8, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 5:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.8, blue: 0.0), Color(red: 1.0, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 6:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 0.0), Color(red: 1.0, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 7:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.8, green: 1.0, blue: 0.0), Color(red: 0.9, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 8:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.6, green: 1.0, blue: 0.0), Color(red: 0.7, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 9:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.4, green: 1.0, blue: 0.0), Color(red: 0.5, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        case 10:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.0, green: 1.0, blue: 0.0), Color(red: 0.2, green: 1.0, blue: 0.2)]), startPoint: startPoint, endPoint: endPoint)
        default:
            return LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.9, blue: 0.9), Color(red: 0.95, green: 0.95, blue: 0.95)]), startPoint: startPoint, endPoint: endPoint)
        }
    }
}
