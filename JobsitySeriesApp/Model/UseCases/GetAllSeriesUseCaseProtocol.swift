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
                   rating: Helper.checkEmptyRating(rating: $0.rating?.average),
                   name: $0.name,
                   image: Poster(imageUrl: $0.image?.medium ?? ""),
                   schedule: Helper.checkEmptySchedules(schedule: $0.schedule),
                   genres: Helper.checkEmptyGenres(genres: $0.genres),
                   summary: $0.summary?.removeHtmlTags() ?? "-")
        }
    }
}
