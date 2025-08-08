//
//  Item.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 8/8/25.
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
