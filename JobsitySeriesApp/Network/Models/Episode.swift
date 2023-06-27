//
//  Episode.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct Episode : Codable {
    var id: Int
    var name: String
    var number: Int
    var season: Int
    var summary: Int
    var image: Picture?
}
