//
//  EpisodeResponse.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct EpisodeResponse: Codable {
    var id: Int
    var name: String
    var number: Int
    var season: Int
    var summary: String?
    var image: PosterResponse?
}
