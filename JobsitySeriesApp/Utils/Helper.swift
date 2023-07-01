//
//  Helper.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation
import RealmSwift

class Helper {
    static func formatSchedules(schedule: ScheduleResponse?) -> Schedule {
        var time: String = schedule?.time ?? ""
        var days: [String] = schedule?.days ?? []

        if time.isEmpty { time = "-" }
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
        if let genresReponse = genres {
            if genresReponse.isEmpty {
                return ["-"]
            }
            return genresReponse
        }
        return ["-"]
    }

    static func removeHtmlTags(string: String?) -> String {
        guard let filledString = string else {
            return "-"
        }
        if filledString.isEmpty {
            return "-"
        }
        return filledString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    static func convertBookmarkedSeriesToSeries(_ bookmarked: BookmarkedSeries) -> Series {
        return Series(id: bookmarked.seriesId, rating: bookmarked.rating,
                      name: bookmarked.name, image: Poster(imageUrl: bookmarked.imageUrl),
                      schedule: Schedule(time: bookmarked.time, days: Array(bookmarked.days)),
                      genres: Array(bookmarked.genres), summary: bookmarked.summary)
    }

    static func convertSeriesToBookmakedSeries(_ series: Series) -> BookmarkedSeries {
        let days = List<String>()
        days.append(objectsIn: series.schedule.days)

        let genres = List<String>()
        genres.append(objectsIn: series.genres)

        return BookmarkedSeries(seriesId: series.id, rating: series.rating,
                                name: series.name, genres: genres,
                                summary: series.summary, imageUrl: series.image.imageUrl,
                                time: series.schedule.time, days: days)
    }
}
