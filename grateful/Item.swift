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
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
