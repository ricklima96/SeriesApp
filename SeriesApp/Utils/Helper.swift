//
//  Helper.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation
import RealmSwift

class Helper {
    static func formatSchedules(schedule: ScheduleResponse?) -> Schedule {
        let time: String = schedule?.time ?? ""
        var days: [String] = schedule?.days ?? []

        if days.isEmpty { days = ["-"] }

        return Schedule(time: time, days: days)
    }

    static func formatRating(rating: Double?) -> String {
        if let ratingResponse = rating {
            return String(ratingResponse)
        }
        return "-"
    }

    static func formatGenres(genres: [String]?) -> [String] {
        return genres?.isEmpty == false ? genres! : ["-"]
    }

    static func removeHtmlTags(string: String?) -> String {
        guard let filledString = string, !filledString.isEmpty else {
            return "-"
        }

        let regex = "<[^>]+>"
        let filteredString = filledString.replacingOccurrences(of: regex, with: "", options: .regularExpression)

        return filteredString
    }

    static func convertBookmarkedSeriesToSeries(_ bookmarked: BookmarkedSeries) -> Series {
        return Series(id: bookmarked.seriesId,
                      rating: bookmarked.rating,
                      name: bookmarked.name,
                      image: Poster(imageUrl: bookmarked.imageUrl),
                      schedule: Schedule(time: bookmarked.time, days: Array(bookmarked.days)),
                      genres: Array(bookmarked.genres),
                      summary: bookmarked.summary)
    }

    static func convertSeriesToBookmakedSeries(_ series: Series) -> BookmarkedSeries {
        let days = List<String>()
        days.append(objectsIn: series.schedule.days)

        let genres = List<String>()
        genres.append(objectsIn: series.genres)

        return BookmarkedSeries(seriesId: series.id,
                                rating: series.rating,
                                name: series.name,
                                genres: genres,
                                summary: series.summary,
                                imageUrl: series.image.imageUrl,
                                time: series.schedule.time,
                                days: days)
    }
}
