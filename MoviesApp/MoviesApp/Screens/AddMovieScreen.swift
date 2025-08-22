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

    private var isFormatValid: Bool {
        !title.isEmptyOrWhitespace && year != nil
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
                .keyboardType(.numberPad)
        }
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
        context.insert(movie)

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
