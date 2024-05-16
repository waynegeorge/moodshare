//
//  Report.swift
//  MyFeelings
//
//  Created by Wayne George on 25/10/2023.
//

import SwiftUI
import SwiftData

@Model
class Card: Identifiable {
    var date: Date
    var complete: Bool
    var score: Int
    var words: [String]
    var positives: String
    var liked: String
    var toShare: String
    
    init(date: Date = Date(),
         complete: Bool = false,
         score: Int = 0, words: [String] = [],
         positives: String = "",
         liked: String = "",
         toShare: String = "") {
            self.date = date
            self.complete = complete
            self.score = score
            self.words = words
            self.positives = positives
            self.liked = liked
            self.toShare = toShare
        }
}
