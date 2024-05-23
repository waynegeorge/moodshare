//
//  HowToUseView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/05/2024.
//

import SwiftUI

struct HowToUseView: View {
        let aboutText = """
    Mood Share is a fantastic way to stay connected with your loved ones and gain deeper insights into your own emotions. Whether you're on your way home from work and want to let your partner or family member know how you're feeling before you arrive, or you're at home wanting to support your partner after a hard day, Mood Share has you covered.
    
    With Mood Share, you can easily share your emotions and receive updates on how your partner, loved one, or child is feeling before they walk through the door. It's a quick and easy way to maintain emotional connections and ensure everyone feels heard and supported.
    
    Additionally, Mood Share can serve as a personal mood tracker. You can monitor your feelings, analyze patterns in your emotions or behavior, and keep track of these patterns over time. This feature is not only useful for personal reflection but can also be shared with your therapist, providing a valuable tool for deeper understanding and more effective therapy sessions.
    
    Stay connected, understand your emotions, and support your loved ones with Mood Share — the convenient and effective way to share and track moods.
    """
    
    var body: some View {
        
        ScrollView {
                Text("Mood Share: Stay Connected with Your Loved Ones and Yourself")
                    .padding()
                    .font(.title3)
                
                Text(aboutText)
                    .padding()
            }
        
    }
}

#Preview {
    HowToUseView()
        .preferredColorScheme(.dark)
}
