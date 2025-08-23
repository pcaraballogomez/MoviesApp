//
//  MovieDetailScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 23/8/25.
//

import SwiftUI
import SwiftData

struct MovieDetailScreen: View {
    
    let movie: Movie
    @Environment(\.modelContext) private var context

    @State private var title: String = ""
    @State private var year: Int?

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            Button("Update") {
                guard let year else { return }
                movie.title = title
                movie.year = year

                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .buttonStyle(.borderless)
        }
        .onAppear {
            title = movie.title
            year = movie.year
        }
    }
}

struct MovieDetailContainerScreen: View {

    @Environment(\.modelContext) private var context
    @State private var movie: Movie?

    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        .onAppear {
            movie = Movie(title: "Spiderman", year: 2013)
            if let movie {
                context.insert(movie)
            }
        }
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self])
}
