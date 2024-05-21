//
//  AppDelegate.swift
//  FeelingCards
//
//  Created by Wayne George on 17/05/2024.
//

import SwiftUI
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    let moodLogManager = MoodLogManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            if granted {
                self.scheduleNotifications()
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        // Schedule daily reset
        moodLogManager.scheduleDailyReset()
        
        return true
    }
    
    func scheduleNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        guard !moodLogManager.hasLoggedMood else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Mood Share Reminder"
        content.body = "Please log and share your mood for the day."
        content.sound = .default
        content.badge = 1        
        
        // Schedule notification for 6:00 PM
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        dateComponents.minute = 00
        let trigger6PM = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request6PM = UNNotificationRequest(identifier: "moodReminder6PM", content: content, trigger: trigger6PM)
        
        // Schedule notification for 7:00 PM
        dateComponents.hour = 19
        dateComponents.minute = 00
        let trigger8PM = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request8PM = UNNotificationRequest(identifier: "moodReminder8PM", content: content, trigger: trigger8PM)
        
        notificationCenter.add(request6PM)
        notificationCenter.add(request8PM)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "resetMoodLogFlag" {
            moodLogManager.resetMoodLogFlag()
        } else {
            completionHandler([.banner, .sound, .badge])
            center.setBadgeCount(1, withCompletionHandler: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "resetMoodLogFlag" {
            moodLogManager.resetMoodLogFlag()
        } else {
            moodLogManager.markMoodAsLogged()
            center.removePendingNotificationRequests(withIdentifiers: ["moodReminder8PM"])
            center.setBadgeCount(0, withCompletionHandler: nil)
        }
        completionHandler()
    }
}
