//
//  FeelingCardsApp.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI

@main
struct FeelingCardsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            //SplashScreenView()
            ContentView()
                .environmentObject(appDelegate.moodLogManager)
        }
        .modelContainer(for: Card.self)
    }
}
