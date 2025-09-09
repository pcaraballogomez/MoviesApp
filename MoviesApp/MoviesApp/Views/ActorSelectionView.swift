//
//  ActorSelectionView.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 9/9/25.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {

    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>

    var body: some View {
        List(actors) { actor in
            HStack {
                let isSelectedActor = selectedActors.contains(actor)
                Image(systemName: isSelectedActor ? "checkmark.square" : "square")
                    .onTapGesture {
                        if isSelectedActor {
                            selectedActors.remove(actor)
                        } else {
                            selectedActors.insert(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}

//#Preview {
//    ActorSelectionView()
//}
