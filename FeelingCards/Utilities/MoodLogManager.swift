//
//  MoodLogManager.swift
//  FeelingCards
//
//  Created by Wayne George on 17/05/2024.
//

import SwiftUI
import Combine
import UserNotifications

class MoodLogManager: ObservableObject {
    @Published var hasLoggedMood: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let lastLoggedDate = UserDefaults.standard.object(forKey: "lastLoggedDate") as? Date
        let today = Calendar.current.startOfDay(for: Date())
        self.hasLoggedMood = (lastLoggedDate == today)
        
        $hasLoggedMood
            .sink { newValue in
                let today = Calendar.current.startOfDay(for: Date())
                if newValue {
                    UserDefaults.standard.set(today, forKey: "lastLoggedDate")
                    self.clearBadge()
                } else {
                    UserDefaults.standard.removeObject(forKey: "lastLoggedDate")
                }
            }
            .store(in: &cancellables)
    }
    
    func markMoodAsLogged() {
        hasLoggedMood = true
    }
    
    func resetMoodLogFlag() {
        self.hasLoggedMood = false
    }
    
    func scheduleDailyReset() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Remove any existing reset notifications
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["resetMoodLogFlag"])
        
        // Schedule the daily reset notification
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        content.sound = nil
        
        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "resetMoodLogFlag", content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling daily reset: \(error)")
            }
        }
    }
    
    private func clearBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)
    }
}
