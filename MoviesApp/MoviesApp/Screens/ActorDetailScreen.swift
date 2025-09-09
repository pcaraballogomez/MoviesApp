//
//  ActorDetailScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import SwiftUI

struct ActorDetailScreen: View {

    @Environment(\.modelContext) private var context

    let actor: Actor
    @State private var selectedMovies: Set<Movie> = []

    var body: some View {
        VStack {
            MovieSelectionView(selectedMovies: $selectedMovies)
                .onAppear {
                    selectedMovies = Set(actor.movies)
                }
        }
        .onChange(of: selectedMovies, {
            actor.movies = Array(selectedMovies)
            context.insert(actor)

        })
        .navigationTitle(actor.name)
    }
}
