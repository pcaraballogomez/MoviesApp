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

//    @Query(
//        filter: #Predicate { !$0.title.isEmpty },
//        sort: \Movie.title,
//        order: .forward
//    ) private var movies: [Movie]
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]

    @State private var actorName = ""
    @State private var activeActionSheet: MovieListScreenActionSheet?
    @State private var filterOption: FilterOption = .none

    var body: some View {

        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter") {
                    activeActionSheet = .showFilter
                }
            }
            .padding()

            MovieListView(filterOption: filterOption)

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
            sheetContent(for: actionSheet)
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
                activeActionSheet = nil
            }
            .disabled(actorName.isEmpty)
        }
    }

    @ViewBuilder
    private func sheetContent(for actionSheet: MovieListScreenActionSheet) -> some View {
        switch actionSheet {
        case .addMovie:
            NavigationStack { AddMovieScreen() }
        case .addActor:
            addActorActionSheet
                .presentationDetents([.fraction(0.25)])
        case .showFilter:
            FilterSelectionScreen(filterOption: $filterOption)
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
