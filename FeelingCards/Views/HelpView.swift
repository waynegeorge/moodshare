//
//  HelpView.swift
//  FeelingCards
//
//  Created by Wayne George on 24/05/2024.
//

import SwiftUI

struct HelpView: View {
    var helpText: String
    
    var body: some View {
        VStack {
            Text(helpText)
                .foregroundColor(.black)
                .padding()
        }
        .background(CardColours.color(for: 5))
        .cornerRadius(20.2)
        .padding()
    }
}

#Preview {
    HelpView(helpText: """
                        Easily score your mood from 1 to 10.
                        
                        A simple yet powerful way to keep track of how you're feeling each day.
                        
                        Tap the screen to log your mood for the day. Once logged, you can tap anytime throughout the day to update it.
                        
                        You can then press the share button to share you log via your preferred method
                        """)
        .preferredColorScheme(.dark)
}
