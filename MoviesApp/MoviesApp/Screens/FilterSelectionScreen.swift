//
//  FilterSelectionScreen.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 14/9/25.
//

import SwiftUI

enum FilterOption {
    case title(String)
    case none
}

struct FilterSelectionScreen: View {

    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
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
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
