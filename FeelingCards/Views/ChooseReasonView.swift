//
//  ChooseReasonView.swift
//  FeelingCards
//
//  Created by Wayne George on 26/01/2024.
//

import SwiftData
import SwiftUI

struct ChooseReasonView: View {
    @Binding var navigationPath: NavigationPath
    @Bindable var card : Card
    @State private var showingShareSheet = false
    
    var body: some View {
        VStack {
            Text("Reason for your score:")
                .bold()
            TextEditor(text: $card.toShare)
                .scrollContentBackground(.hidden)
                .background(CardColours.color(for: card.score))
            
            Spacer()
        }
        .frame(width: 324, height: 420)
        .onTapGesture {
            // Dismiss the keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareView(itemsToShare: ["Today I feel like a \(card.score) \(CardDetails.emojiScale[card.score - 1]).", "I feel this way because \(card.toShare).", "Words I've chosen to describe how I feel are \(card.words.joined(separator: ", "))."])
        }
        .padding()
        .background(CardColours.color(for: card.score))
        .foregroundColor(.black)
        .cornerRadius(20.2)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationPath.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigationPath = NavigationPath()
                } label: {
                    Text("Done")
                }
            }
        }
        
        Spacer()
    }    
}
