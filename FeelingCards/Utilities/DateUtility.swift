//
//  DateUtility.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import Foundation

class DateUtility {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d'th' MMM yyyy"
        formatter.locale = Locale(identifier: "en_US") // Adjust the locale if needed

        // Custom handling for 'st', 'nd', 'rd', 'th'
        return formatter.string(from: date).replacingOccurrences(of: "th", with: ordinalSuffix(for: date))
    }

    private static func ordinalSuffix(for date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        switch day {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
}

extension Date {
    var midnight: Date {
        Calendar.current.startOfDay(for: self)
    }
}
