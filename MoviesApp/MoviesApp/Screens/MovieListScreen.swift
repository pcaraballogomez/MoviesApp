//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 13/8/25.
//

import SwiftUI
import SwiftData

enum MovieListScreenActionSheet: Identifiable {
    case addMovie
    case addActor
    case showFilter

    var id: Int { hashValue }
}

struct MovieListScreen: View {

    @Environment(\.modelContext) private var context


    @State private var actorName = ""
    @State private var activeActionSheet: MovieListScreenActionSheet?

    var body: some View {

        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle)
                .padding()
            MovieListView(movies: movies)

            Text("Actors")
                .font(.largeTitle)
                .padding()
            ActorListView(actors: actors)
        }

        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    activeActionSheet = .addActor
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    activeActionSheet = .addMovie
                }
            }
        }
        .sheet(item: $activeActionSheet, content: { actionSheet in
            switch actionSheet {
            case .addMovie:
                NavigationStack {
                    AddMovieScreen()
                }
            case .addActor:
                addActorActionSheet
                    .presentationDetents([.fraction(0.25)])
            case .showFilter:
                Text("Show filter screen")
            }
        })
    }

    private var addActorActionSheet: some View {
        VStack {
            Text("Add Actor")
                .font(.largeTitle)

            TextField("Actor name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Save") {
                saveActor()
            }
        }
    }

    private func saveActor() {
        guard !actorName.isEmpty else { return }
        
        let actor = Actor(name: actorName)
        context.insert(actor)
        actorName = ""
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [
                Movie.self,
                Actor.self
            ])
    }
}
