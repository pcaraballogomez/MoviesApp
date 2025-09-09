//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 13/8/25.
//

import SwiftUI
import SwiftData

struct MovieListScreen: View {

    @Environment(\.modelContext) private var context

    @Query(sort: \Movie.title, order: .reverse) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .reverse) private var actors: [Actor]

    @State private var actorName = ""
    // TODO: Refactor to enum
    @State private var isAddMoviePresented: Bool = false
    @State private var isAddActorPresented: Bool = false

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
                    isAddActorPresented = true
                }
            }
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
        .sheet(isPresented: $isAddActorPresented) {
            NavigationStack {
                // TODO: Create view
                Text("Add Actor")
                    .font(.largeTitle)

                TextField("Actor name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .presentationDetents([.fraction(0.25)])
                    .padding()

                Button("Save") {
                    isAddActorPresented = false
                    saveActor()
                }

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
