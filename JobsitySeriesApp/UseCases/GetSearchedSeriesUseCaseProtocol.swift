//
//  GetSearchedSeriesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 28/06/23.
//

import Foundation

protocol GetSearchedSeriesUseCaseProtocol {
    func getSearchedSeries(query: String) async throws -> [Series]
}

class GetSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol {
    func getSearchedSeries(query: String) async throws -> [Series] {
        let seriesResponse = try await SeriesService.shared.fetchSearchedSeries(query: query)
        
        return seriesResponse.map {
            Series(id: String($0.show.id),
                   rating: Helper.checkEmptyRating(rating: $0.show.rating?.average),
                   name: $0.show.name,
                   image: Poster(imageUrl: $0.show.image?.medium),
                   schedule: Helper.checkEmptySchedules(schedule: $0.show.schedule),
                   genres: Helper.checkEmptyGenres(genres: $0.show.genres),
                   summary: $0.show.summary?.removeHtmlTags() ?? "-")
        }
    }
}
