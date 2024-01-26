//
//  WordItem.swift
//  FeelingCards
//
//  Created by Wayne George on 25/01/2024.
//

import SwiftUI

struct WordItem {
    var id = UUID()
    var word: String
    var isSelected: Bool = false
}

let wordList: [String] = ["Reflective", "Happy", "Hopeful", "Stressed", "Nervous", "Anxious", "Insecure", "Confused", "Proud", "Tired", "Hurt", "Excited", "Disappointed", "Annoyed", "Inspired", "Frustrated", "Calm", "Neutral", "Lonely", "Low", "Secure", "Confident", "Scared", "Guilty", "Sad", "Overwhelmed", "Rejected", "Abandoned"]
