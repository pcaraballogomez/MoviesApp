//
//  Actor.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import Foundation
import SwiftData

@Model
final class Actor {
    var name: String
    var movies: [Movie] = []

    init(name: String, movies: [Movie] = []) {
        self.name = name
        self.movies = movies
    }
}
