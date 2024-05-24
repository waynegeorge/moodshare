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
    @State private var score: Int = 5
    @EnvironmentObject var moodLogManager: MoodLogManager
    @Environment(\.dismiss) var dismiss
    @State private var showingHelpSheet = false
    
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
            
            Picker("How do you feel today?", selection: $score) {
                ForEach(numbers, id: \.self) { number in
                    Text("\(number) \(CardDetails.emojiScale[number - 1])")
                        .foregroundColor(.black)  // Set text color to black
                        .font(.headline)          // Increase font size
                        .tag(number)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
        }
        .frame(width: 324, height: 420)
        
        .onAppear {
            score = card.score == 0 ? 5 : card.score
        }
        .onDisappear {
            
        }
        .sheet(isPresented: $showingHelpSheet) {
            let helpText = "score"
            HelpView(helpText: helpText)
        }
        .padding()
        .background(CardColours.color(for: score))
        .foregroundColor(.black)
        .cornerRadius(9)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    card.score = score
                    navigationPath.removeLast()
                    moodLogManager.markMoodAsLogged()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showingHelpSheet = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    card.score = score
                    navigationPath = NavigationPath()
                    moodLogManager.markMoodAsLogged()
                } label: {
                    Text("Done")
                }
            }
        }
        
        Button {
            card.score = score
            navigationPath.append(ViewDestination.chooseWords)            
            moodLogManager.markMoodAsLogged()
        } label: {
            Text("Next")
                .font(.headline)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 5, leading: 40, bottom: 5, trailing: 40))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                )
                .padding(.top, 30)
        }
        
        Spacer()
    }
}
