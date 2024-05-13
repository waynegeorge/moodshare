//
//  HistoryView.swift
//  FeelingCards
//
//  Created by Wayne George on 23/11/2023.
//

import SwiftUI

struct HistoryView: View {
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
            }
            .frame(width: 324, height: 420)
            .padding()
            .foregroundColor(.black)
            .cornerRadius(9)
            .navigationTitle("History")
            
            Spacer()
        }
        
        VStack {
            Text("Hello")
        }
    }
}

#Preview {
    HistoryView()
}
