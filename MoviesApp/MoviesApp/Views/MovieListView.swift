//
//  MovieListView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 23/8/25.
//

import SwiftUI
import SwiftData

struct MovieListView: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    let filterOption: FilterOption

    // Filtrado en memoria. Cuidado si tengo muchos registros
    var filteredMovies: [Movie] {
        switch filterOption {
        case .title(let movieTitle):
            return movies.filter { $0.title.localizedStandardContains(movieTitle) }
        case .none:
            return movies
        }
    }

    // Filtro en base de datos
    //    init(filterOption: FilterOption = .none) {
    //        self.filterOption = filterOption
    //
    //        switch filterOption {
    //        case .title(let movieTitle):
    //            _movies = Query(filter: #Predicate { $0.title.localizedStandardContains(movieTitle) })
    //        case .none:
    //            _movies = Query()
    //        }
    //    }

    var body: some View {
        List {
            ForEach(filteredMovies) { movie in
                NavigationLink(value: movie) {
                    MovieRow(movie: movie)
                }
            }
            .onDelete(perform: deleteMovie)
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailScreen(movie: movie)
        }
    }

    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            context.delete(movie)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MovieListView(filterOption: .none)
        .modelContainer(for: [Movie.self])
}
