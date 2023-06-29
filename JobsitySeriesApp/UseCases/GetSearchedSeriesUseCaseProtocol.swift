//
//  GetSearchedSeriesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 28/06/23.
//

import Foundation

protocol GetSearchedSeriesUseCaseProtocol {
    func getSearchedSeries(query: String, completionHandler: @escaping (Result<[Series], Error>) -> Void)
}

class GetSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol {
    func getSearchedSeries(query: String, completionHandler: @escaping (Result<[Series], Error>) -> Void) {
        
        SeriesService.shared.fetchSearchedSeries(query: query) { result in
            switch result {
            case .success(let searchResponse):
                let series = searchResponse.map {
                    Series(id: String($0.show.id),
                           rating: Helper.checkEmptyRating(rating: $0.show.rating?.average),
                           name: $0.show.name ?? "-",
                           image: $0.show.image ?? Picture(),
                           schedule: Helper.checkEmptySchedules(schedule: $0.show.schedule),
                           genres: $0.show.genres ?? [],
                           summary: $0.show.summary?.removeHtmlTags() ?? "-")
                    
                    
                }
                completionHandler(.success(series))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
