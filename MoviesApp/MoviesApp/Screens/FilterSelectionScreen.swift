//
//  FilterSelectionScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 14/9/25.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case reviewsCount(Int)
    case actorsCount(Int)
    case none
}

struct FilterSelectionScreen: View {

    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    @State private var numberOfReviews: Int?
    @State private var numberOfActors: Int?
    @Binding var filterOption: FilterOption

    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button("Seach") {
                    filterOption = .title(movieTitle)
                    dismiss()
                }
                .disabled(movieTitle.isEmpty)
            }

            Section("Filter by number of reviews") {
                TextField("Movie reviews", value: $numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button("Seach") {
                    filterOption = .reviewsCount(numberOfReviews ?? .zero)
                    dismiss()
                }
                .disabled(numberOfReviews == nil)
            }

            Section("Filter by number of actors") {
                TextField("Movie actors", value: $numberOfActors, format: .number)
                    .keyboardType(.numberPad)
                Button("Seach") {
                    filterOption = .actorsCount(numberOfActors ?? .zero)
                    dismiss()
                }
                .disabled(numberOfActors == nil)
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
