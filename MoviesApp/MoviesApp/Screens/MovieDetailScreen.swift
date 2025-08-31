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
    @State private var showReviewScreen: Bool = false

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

            Section("Reviews") {
                Button {
                    showReviewScreen = true
                } label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                if movie.reviews.isEmpty {
                    ContentUnavailableView {
                        Text("No reviews")
                    }
                } else {
                    ReviewListView(movie: movie)
                }

            }
        }
        .onAppear {
            title = movie.title
            year = movie.year
        }
        .sheet(isPresented: $showReviewScreen) {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
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
