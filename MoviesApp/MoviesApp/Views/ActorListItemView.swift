//
//  ActorListItemView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import SwiftUI

struct ActorListItemView: View {

    let actor: Actor

    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
            Text(actor.movies.map { $0.title},
                 format: .list(type: .and))
                .font(.caption)
        }
    }
}

//#Preview {
//    ActorListItemView()
//}
