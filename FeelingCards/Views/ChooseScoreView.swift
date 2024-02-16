//
//  EditCardView.swift
//  FeelingCards
//
//  Created by Wayne George on 26/11/2023.
//

import SwiftData
import SwiftUI

struct ChooseScoreView: View {
    @Binding var navigationPath: NavigationPath
    @Bindable var card : Card
    
    @Environment(\.dismiss) var dismiss
    let numbers = Array(1...10)
    
    var body: some View {
        VStack {
            HStack {
                Text(DateUtility.formattedDate(Date.now))
                    .foregroundColor(.black)
                    .bold()
                    .frame(width: 200, height: 30)
                    .border(Color.black, width: 2)
            }
            
            Picker("How do you feel today?", selection: $card.score) {
                ForEach(numbers, id: \.self) { number in
                    Text("\(number) \(CardDetails.emojiScale[number - 1])")
                        .foregroundColor(.black)  // Set text color to black
                        .font(.headline)          // Increase font size
                        .tag(number)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 300, height: 150) // Set the frame size of the Picker

            
//
        }
        .padding()
        .background(CardColours.color(for: card.score))
        .foregroundColor(.black)
        .cornerRadius(9)
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
        
        Button("Next") {
            navigationPath.append(ViewDestination.chooseWords)
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
        let example1 = Card(score: 8)
        let example2 = Card(score: 2, words: [words[0], words[1], words[2]], positives: "My friends liked my hair a lot", liked: "I liked that I was able to take the complements and not feel awkward", toShare: "I had a great time at school because everyone liked my hair")
        return ChooseScoreView(navigationPath: .constant(NavigationPath()), card: example1)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
