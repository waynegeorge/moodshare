//
//  ChooseWordsView.swift
//  FeelingCards
//
//  Created by Wayne George on 25/01/2024.
//

import SwiftData
import SwiftUI

struct ChooseWordsView: View {
    @Binding var navigationPath: NavigationPath
    @Bindable var card : Card
    @State private var selection = Set<String>()
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Text("Select words")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .bold()
                
            }
            
            FlowLayout(alignment: .leading, spacing: 10) {
                ForEach(CardDetails.words, id: \.self) { word in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selection.contains(word) ? Color(red: 0.678, green: 1, blue: 1) : Color.clear))
                        
                        Text(word)
                            .padding(5)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                if selection.contains(word) {
                                    selection.remove(word)
                                } else {
                                    selection.insert(word)
                                }
                                card.words = Array(selection)
                                
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            HStack {
                Button("Choose all") {
                    selection = Set(CardDetails.words)
                    card.words = CardDetails.words
                }
                .padding(.leading)
                
                Spacer()
                
                Button("Clear") {
                    selection = Set<String>()
                    card.words = Array(selection)
                }
                .padding(.trailing)
            }
            .padding(.top, 40)
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [CardColours.color(for: card.score), CardColours.color(for: card.score - 1)]), startPoint: .leading, endPoint: .trailing))
        .foregroundColor(.black)
        .cornerRadius(20.2)
        .onAppear() {
            selection = Set(card.words)
        }
        
        Button("Next") {
            navigationPath.append(ViewDestination.chooseReason)
        }
        .font(.headline)
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 5, leading: 40, bottom: 5, trailing: 40))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
        )
        .padding(.top, 40)
        
        Button("Done") {
            navigationPath = NavigationPath()
        }
        .padding(.top, 10)
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
        return ChooseWordsView(navigationPath: .constant(NavigationPath()), card: example2)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
