//
//  Item.swift
//  grateful
//
//  Created by Ian Shimabukuro on 8/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date // When you were grateful for
    var gratitude: String //What are you grateful for
    var mood: String
    
    init(timestamp: Date, gratitude: String, mood: String) {
        self.timestamp = timestamp
        self.gratitude = gratitude
        self.mood = mood
    }
}
