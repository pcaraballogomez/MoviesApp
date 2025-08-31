//
//  ReviewListView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 31/8/25.
//

import SwiftUI

struct ReviewListView: View {

    let reviews: [Review]

    var body: some View {
        List {
            ForEach(reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                    Text(review.body)
                }
            }
        }
    }
}

#Preview {
    ReviewListView(reviews: [])
}
