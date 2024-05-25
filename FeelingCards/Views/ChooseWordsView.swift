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
    @State private var showingHelpSheet = false
    
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
        .frame(width: 324, height: 420)
        .padding()
        .background(CardColours.color(for: card.score))
        .foregroundColor(.black)
        .cornerRadius(20.2)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showingHelpSheet) {
            let helpText = """
                Choose words to help you explore the reasons behind your mood. 
                
                Understand the deeper emotions and circumstances influencing your feelings.
                """
            HelpView(helpText: helpText)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationPath.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showingHelpSheet = true
                } label: {
                    Image(systemName: "info.circle")
                }
                .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigationPath = NavigationPath()
                } label: {
                    Text("Done")
                }
                .foregroundColor(.white)
            }
        }
        .onAppear() {
            selection = Set(card.words)
        }
        
        Button {
            navigationPath.append(ViewDestination.chooseReason)
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
