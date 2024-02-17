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
                .frame(height: 200)
                .background(LinearGradient(gradient: Gradient(colors: [CardColours.color(for: card.score), CardColours.color(for: card.score - 1)]), startPoint: .leading, endPoint: .trailing))
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareView(itemsToShare: ["Today I feel like a \(card.score) \(CardDetails.emojiScale[card.score - 1]).", "I feel this way because \(card.toShare).", "Words I've chosen to describe how I feel are \(card.words.joined(separator: ", "))."])
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [CardColours.color(for: card.score), CardColours.color(for: card.score - 1)]), startPoint: .leading, endPoint: .trailing))
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
                Button("Done") {
                    navigationPath = NavigationPath()
                }
            }
        }
        
        Button("Share") {
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
