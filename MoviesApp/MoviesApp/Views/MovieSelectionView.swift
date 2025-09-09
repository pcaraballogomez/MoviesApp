//
//  MovieSelectionView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {

    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie>

    var body: some View {
        List(movies) { movie in
            HStack {
                let isSelectedMovie = selectedMovies.contains(movie)
                Image(systemName: isSelectedMovie ? "checkmark.square" : "square")
                    .onTapGesture {
                        if isSelectedMovie {
                            selectedMovies.remove(movie)
                        } else {
                            selectedMovies.insert(movie)
                        }
                    }
                Text(movie.title)
            }
        }
    }
}
