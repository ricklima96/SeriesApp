//
//  GetAllSeriesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

protocol GetAllSeriesUseCaseProtocol {
    func getAllSeries(page: Int, completionHandler: @escaping (Result<[Series], Error>) -> Void)
}

class GetAllSeriesUseCase: GetAllSeriesUseCaseProtocol {
    func getAllSeries(page: Int, completionHandler: @escaping (Result<[Series], Error>) -> Void) {
        SeriesService.shared.fetchAllSeries(page: page) { result in
            switch result {
            case.success(let seriesReponse):
                let series = seriesReponse.map {
                    Series(id: String($0.id), name: $0.name ?? "", image: $0.image,
                                                       schedule: $0.schedule, genres: $0.genres ?? [],
                           summary: $0.summary?.removeHtmlTags() ?? "")
                }
                completionHandler(.success(series))
            case.failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
