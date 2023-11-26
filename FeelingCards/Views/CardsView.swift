//
//  HomeView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<6, id: \.self) { item in
                    let cardColor = CardColours.CardColor(rawValue: item)?.color ?? .gray
                    
                    Text("Card \(item+1)")
                        .frame(width: 350, height: 300)
                        .background(cardColor)
                        .cornerRadius(10)
                        .padding(1)
                }
            }
            .navigationTitle("Feeling Cards")
        }
    }
}



#Preview {
    CardsView()
}
