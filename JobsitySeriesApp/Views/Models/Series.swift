//
//  Series.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct Series {
    var id: String
    var rating: String
    var name: String
    var image: Poster
    var schedule: Schedule
    var genres: [String]
    var summary: String
}

struct Schedule {
    var time: String
    var days: [String]
}
