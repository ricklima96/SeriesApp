//
//  GetAllEpisodesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

protocol GetAllEpisodesUseCaseProtocol {
    func getAllEpisodes(id: String, completionHandler: @escaping (Result<[Episode], Error>) -> Void)
}

class GetAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol {
    func getAllEpisodes(id: String, completionHandler: @escaping (Result<[Episode], Error>) -> Void) {
        SeriesService.shared.fetchAllEpisodes(id: id) { result in
            switch result {
            case .success(let episodesResponse):
                let episodes = episodesResponse.map {
                    Episode(id: String($0.id),
                            name: $0.name,
                            number: String($0.number),
                            season: String($0.season),
                            summary: $0.summary.removeHtmlTags(),
                            image: $0.image ?? Picture())
                }
                completionHandler(.success(episodes))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
