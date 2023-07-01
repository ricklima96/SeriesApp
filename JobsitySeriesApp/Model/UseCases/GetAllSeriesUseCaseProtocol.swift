//
//  GetAllSeriesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

protocol GetAllSeriesUseCaseProtocol {
    func getAllSeries(page: Int) async throws -> [Series]
}

final class GetAllSeriesUseCase: GetAllSeriesUseCaseProtocol {

    private var seriesService: SeriesServiceProtocol

    init(seriesService: SeriesServiceProtocol = SeriesService()) {
        self.seriesService = seriesService
    }

    func getAllSeries(page: Int) async throws -> [Series] {
        let seriesResponse = try await seriesService.fetchAllSeries(page: page)

        return seriesResponse.map {
            Series(id: String($0.id),
                   rating: Helper.formatRating(rating: $0.rating?.average),
                   name: $0.name,
                   image: Poster(imageUrl: $0.image?.medium ?? ""),
                   schedule: Helper.formatSchedules(schedule: $0.schedule),
                   genres: Helper.formatGenres(genres: $0.genres),
                   summary: Helper.removeHtmlTags(string: $0.summary))
        }
    }
}
