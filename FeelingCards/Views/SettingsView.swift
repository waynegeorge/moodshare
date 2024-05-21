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
                Section ("General"){
                    HStack {
                        Text("App Version")
                        
                        Spacer()
                        
                        Text("\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Contact the developer")
                        
                        Spacer()
                        
                        Button(action: sendEmail) {
                            Text("Email")
                        }
                    }
                    
                    Text("Developed by Wayne George")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func sendEmail() {
        let recipient = "feedback@waynegeorge.tech"
        let subject = "Mood Share App Feedback"
        let body = "Hi,\n\n\n\n\(getAppDetails())"
        
        if let url = createEmailUrl(to: recipient, subject: subject, body: body), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Cannot open mail app")
        }
    }
    
    func createEmailUrl(to recipient: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "mailto:\(recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        return URL(string: urlString)
    }
    
    func getAppDetails() -> String {
        _ = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "App"
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown Version"
        let deviceModel = UIDevice.current.model
        let systemVersion = UIDevice.current.systemVersion
        
        return "App: Mood Share, Version: \(appVersion)\nDevice: \(deviceModel), iOS Version: \(systemVersion)"
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
