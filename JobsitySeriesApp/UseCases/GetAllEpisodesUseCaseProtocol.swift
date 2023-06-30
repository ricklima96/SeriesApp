//
//  GetAllEpisodesUseCaseProtocol.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

protocol GetAllEpisodesUseCaseProtocol {
    func getAllEpisodes(id: String) async throws -> [Episode]
}

class GetAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol {
    func getAllEpisodes(id: String) async throws -> [Episode] {
        let episodeResponse = try await SeriesService.shared.fetchAllEpisodes(id: id)
        
        return episodeResponse.map {
            Episode(id: String($0.id),
                    name: $0.name,
                    number: String($0.number),
                    season: String($0.season),
                    summary: $0.summary?.removeHtmlTags() ?? "-",
                    image: Poster(imageUrl: $0.image?.medium))
        }
    }
}
