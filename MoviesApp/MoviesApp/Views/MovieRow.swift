//
//  MovieRow.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 14/9/25.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(movie.title)
                Text("Number of reviews: \(movie.reviewsCount)")
                    .font(.caption)
                Text("Number of actors: \(movie.actorsCount)")
                    .font(.caption)
            }
            Spacer()
            Text(movie.year.description)
        }
    }
}


#Preview {
    MovieRow(movie: Movie(title: "Batman", year: 2024))
        .padding()
}
