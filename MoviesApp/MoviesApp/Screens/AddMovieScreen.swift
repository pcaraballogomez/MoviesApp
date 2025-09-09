//
//  AddMovieScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 8/8/25.
//

import SwiftUI
import SwiftData

struct AddMovieScreen: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var title = ""
    @State private var year: Int?
    @State private var selectedActors: Set<Actor> = []

    private var isFormatValid: Bool {
        !title.isEmptyOrWhitespace && year != nil && !selectedActors.isEmpty
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
                .keyboardType(.numberPad)

            Section("Select Actors") {
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        // Good way to debug
//        .onChange(of: selectedActors, { _, _ in
//            print(selectedActors.count)
//        })
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveMovie()
                    dismiss()
                }.disabled(!isFormatValid)
            }
        }
    }

    private func saveMovie() {
        guard let year else { return }

        let movie = Movie(title: title, year: year)
        movie.actors = Array(selectedActors)

        selectedActors.forEach { actor in
            actor.movies.append(movie)
            context.insert(actor)
        }

        context.insert(movie)

        // Its not necessary
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack{
        AddMovieScreen()
            .modelContainer(for: [Movie.self])
    }
}
