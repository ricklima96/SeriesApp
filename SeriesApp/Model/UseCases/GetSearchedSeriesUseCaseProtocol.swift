//
//  GetSearchedSeriesUseCaseProtocol.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 28/06/23.
//

import Foundation

protocol GetSearchedSeriesUseCaseProtocol {
    func getSearchedSeries(query: String) async throws -> [Series]
}

final class GetSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol {

    private let seriesService: SeriesServiceProtocol

    init(seriesService: SeriesServiceProtocol = SeriesService()) {
        self.seriesService = seriesService
    }

    func getSearchedSeries(query: String) async throws -> [Series] {
        let seriesResponse = try await seriesService.fetchSearchedSeries(query: query)

        return seriesResponse.map {
            Series(id: String($0.show.id),
                   rating: Helper.formatRating(rating: $0.show.rating?.average),
                   name: $0.show.name,
                   image: Poster(imageUrl: $0.show.image?.medium ?? ""),
                   schedule: Helper.formatSchedules(schedule: $0.show.schedule),
                   genres: Helper.formatGenres(genres: $0.show.genres),
                   summary: Helper.removeHtmlTags(string: $0.show.summary))
        }
    }
}
