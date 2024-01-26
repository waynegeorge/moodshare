//
//  SettingsView.swift
//  FeelingCards
//
//  Created by Wayne George on 20/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearanceMode") var selectedMode = AppearanceMode.system

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Select Mode", selection: $selectedMode) {
                        Text("System").tag(AppearanceMode.system)
                        Text("Light").tag(AppearanceMode.light)
                        Text("Dark").tag(AppearanceMode.dark)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Settings")
        }
    }
}

enum AppearanceMode: Int, Identifiable {
    case system = 0
    case light = 1
    case dark = 2

    var id: Int { self.rawValue }
}

#Preview {
    SettingsView()
}
