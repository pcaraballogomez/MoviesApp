//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 13/8/25.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {

    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @State private var isAddMoviePresented: Bool = false

    var body: some View {
        MovieListView(movies: movies)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    isAddMoviePresented = true
                }
            }
        }
        .sheet(isPresented: $isAddMoviePresented) {
            NavigationStack {
                AddMovieScreen()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self])
    }
}
