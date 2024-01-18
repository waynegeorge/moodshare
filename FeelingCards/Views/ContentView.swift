//
//  ContentView.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                
                AveragesView()
                    .tabItem {
                        Label("Averages", systemImage: "chart.bar.fill")
                    }
                    .tag(2)
                
                CardsView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(1)
                
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(0)
            }
        }
        .navigationTitle("Hello")
    }
}

#Preview {
    ContentView()
}
