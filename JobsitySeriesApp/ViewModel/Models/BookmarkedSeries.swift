//
//  BookmarkedSeries.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 01/07/23.
//

import Foundation
import RealmSwift

class BookmarkedSeries: Object, ObjectKeyIdentifiable {

    convenience init(seriesId: String, rating: String,
                     name: String, genres: List<String>,
                     summary: String, imageUrl: String,
                     time: String, days: List<String>) {
        self.init()
        self.seriesId = seriesId
        self.rating = rating
        self.name = name
        self.genres = genres
        self.summary = summary
        self.imageUrl = imageUrl
        self.time = time
        self.days = days
    }

    @Persisted(primaryKey: true) var seriesId: String
    @Persisted var rating: String
    @Persisted var name: String
    @Persisted var genres: List<String>
    @Persisted var summary: String
    @Persisted var imageUrl: String
    @Persisted var time: String
    @Persisted var days: List<String>
}
