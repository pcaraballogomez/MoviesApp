//
//  Review.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 31/8/25.
//

import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var body: String
    var movie: Movie?

    init(subject: String, body: String, movie: Movie? = nil) {
        self.subject = subject
        self.body = body
        self.movie = movie
    }
}
