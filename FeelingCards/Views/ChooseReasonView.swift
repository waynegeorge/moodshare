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
                .overlay(
                    Group {
                        if card.toShare.isEmpty {
                            Text("Enter text here...")
                                .foregroundColor(.gray)
                                .padding(.leading, 4)
                                .padding(.top, 8)
                        }
                    }, alignment: .topLeading
                )
                .scrollContentBackground(.hidden)
                .background(CardGradients.gradient(for: card.score))
            
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
        .background(CardGradients.gradient(for: card.score))
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
        }
        
        Button("Share", systemImage: "square.and.arrow.up") {
            showingShareSheet = true
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 5, leading: 40, bottom: 5, trailing: 40))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
        )
        .padding(.top, 40)
        
        Button("maybe later") {
            navigationPath = NavigationPath()
        }
        .padding(.top, 20)
        Spacer()
    }
    
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Card.self, configurations: config)
        let words = CardDetails.words
        let example1 = Card(score: 0)
        let example2 = Card(score: 8, words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        return ChooseReasonView(navigationPath: .constant(NavigationPath()), card: example2)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
