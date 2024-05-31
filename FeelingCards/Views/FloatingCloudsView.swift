//
//  FloatingCloudsView.swift
//  FeelingCards
//
//  Created by Wayne George on 30/05/2024.
//

import SwiftUI

struct FloatingCloudsView: View {
    var colourIndex: Int
    let blur: CGFloat = 60

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Theme.generalBackground
                ZStack {
                    Cloud(proxy: proxy,
                          color: CardColours.color(for: colourIndex, opacity: 0.8),
                          rotationStart: 360,
                          duration: 5,
                          alignment: .bottomTrailing)
                    Cloud(proxy: proxy,
                          color: CardColours.color(for: colourIndex, opacity: 0.8),
                          rotationStart: 240,
                          duration: 15,
                          alignment: .topTrailing)
                    Cloud(proxy: proxy,
                          color: CardColours.color(for: colourIndex, opacity: 0.8),
                          rotationStart: 120,
                          duration: 10,
                          alignment: .bottomLeading)
                    Cloud(proxy: proxy,
                          color: CardColours.color(for: colourIndex, opacity: 0.8),
                          rotationStart: 180,
                          duration: 20,
                          alignment: .topLeading)
                }
                .blur(radius: blur)
            }
            .ignoresSafeArea()
        }
    }
}

struct Cloud: View {
    @StateObject var provider = CloudProvider()
    @State var move = false
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double
    let alignment: Alignment

    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360))
            .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: move)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}

struct Theme {
    static var generalBackground: Color {
        Color(red: 0.043, green: 0.467, blue: 0.494)
    }
}

class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat

    init() {
        frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
        offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
                        height: CGFloat.random(in: -150 ..< 150))
    }
}
