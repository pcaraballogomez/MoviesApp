//
//  String+Extensions.swift
//  MoviesApp
//
//  Created by Pablo Caraballo Gómez on 8/8/25.
//

extension String {

    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
