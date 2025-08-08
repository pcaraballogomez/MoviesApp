//
//  Movie.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 8/8/25.
//

import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var year: Int

    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
