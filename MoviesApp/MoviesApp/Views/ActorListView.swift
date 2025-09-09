//
//  ActorListView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import SwiftUI

struct ActorListView: View {
    let actors: [Actor]

    var body: some View {
        List(actors) { actor in
            NavigationLink(value: actor) {
                ActorListItemView(actor: actor)
            }
        }
        .navigationDestination(for: Actor.self) { actor in
            ActorDetailScreen(actor: actor)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
