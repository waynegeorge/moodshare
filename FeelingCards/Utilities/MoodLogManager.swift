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
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                } else {
                    UserDefaults.standard.removeObject(forKey: "lastLoggedDate")
                    self.scheduleNotifications()
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
        content.badge = 0
        
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
    
    private func scheduleNotifications() {
        guard !hasLoggedMood else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Mood Share Reminder"
        content.body = "Please log and share your mood for the day."
        content.sound = .default
        
        // Schedule notification for 8:55 PM
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 55
        let trigger6PM = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request6PM = UNNotificationRequest(identifier: "moodReminder6PM", content: content, trigger: trigger6PM)
        
        // Schedule notification for 8:56 PM
        dateComponents.hour = 20
        dateComponents.minute = 56
        let trigger8PM = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request8PM = UNNotificationRequest(identifier: "moodReminder8PM", content: content, trigger: trigger8PM)
        
        UNUserNotificationCenter.current().add(request6PM)
        UNUserNotificationCenter.current().add(request8PM)
    }
}
