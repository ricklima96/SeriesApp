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
            case.success(let seriesReponse):
                let series = seriesReponse.map {
                    Series(id: $0.id, name: $0.name ?? "", image: $0.image,
                                                       schedule: $0.schedule, genres: $0.genres ?? [],
                                                       summary: $0.summary ?? "")
                }
                completionHandler(.success(series))
            case.failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
