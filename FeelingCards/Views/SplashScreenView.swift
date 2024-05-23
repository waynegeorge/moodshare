//
//  SplashScreenView.swift
//  FeelingCards
//
//  Created by Wayne George on 22/05/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(red: 0.00, green: 0.78, blue: 0.747)
                VStack {
                    VStack {
                        Text("🙂")
                            .font(.system(size: 180))
                        Text("Mood Share")
                            .font(Font.custom("Baskerville-Bold", size: 46))
                            .foregroundColor(.black.opacity(0.80))
                            .padding()
                        Text("Share your mood with someone close")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                            .foregroundColor(.black.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    SplashScreenView()
}
