//
//  SeriesResponse.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct SeriesResponse: Codable {
    var id: Int
    var url: String?
    var name: String?
    var image: Picture
    var schedule: Schedule
    var genres: [String]?
    var summary: String?
}

struct Schedule: Codable {
    var time: String?
    var days: [String]?
}

struct Picture: Codable {
    var medium: String?
    var original: String?
}
