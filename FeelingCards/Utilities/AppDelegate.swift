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
        guard !moodLogManager.hasLoggedMood else {
            return
        }
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Mood Log Reminder"
        content.body = "Please log your mood for the day."
        content.sound = .default
        
        // Schedule notification for 6 PM
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        dateComponents.minute = 00
        let trigger6PM = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request6PM = UNNotificationRequest(identifier: "moodReminder6PM", content: content, trigger: trigger6PM)
        
        // Schedule notification for 8 PM
        dateComponents.hour = 20
        dateComponents.minute = 0
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
        }
        center.setBadgeCount(1, withCompletionHandler: nil)
        completionHandler()
    }
}
