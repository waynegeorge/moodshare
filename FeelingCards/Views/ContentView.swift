//
//  ContentView.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    @Query var cards: [Card]
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                Group {
                    CardsView(cards: cards)
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(0)
                    
                    AveragesView()
                        .tabItem {
                            Label("Averages", systemImage: "chart.bar.fill")
                        }
                        .tag(1)
                    
                    HistoryView()
                        .tabItem {
                            Label("History", systemImage: "clock.arrow.circlepath")
                        }
                        .tag(2)
                    
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                        .tag(3)
                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        }
        .navigationTitle("Hello")
    }
}
