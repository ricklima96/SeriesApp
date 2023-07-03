//
//  SeriesResponse.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct SeriesResponse: Codable {
    var id: Int
    var url: String?
    var name: String
    var image: PosterResponse?
    var schedule: ScheduleResponse?
    var rating: RatingResponse?
    var genres: [String]?
    var summary: String?
}

struct ScheduleResponse: Codable {
    var time: String?
    var days: [String]?
}

struct RatingResponse: Codable {
    var average: Double?
}

struct PosterResponse: Codable {
    var medium: String?
    var original: String?
}
