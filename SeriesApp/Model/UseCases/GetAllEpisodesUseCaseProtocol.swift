//
//  GetAllEpisodesUseCaseProtocol.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

protocol GetAllEpisodesUseCaseProtocol {
    func getAllEpisodes(id: String) async throws -> [Episode]
}

final class GetAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol {

    private let seriesService: SeriesServiceProtocol

    init(seriesService: SeriesServiceProtocol = SeriesService()) {
        self.seriesService = seriesService
    }

    func getAllEpisodes(id: String) async throws -> [Episode] {
        let episodeResponse = try await seriesService.fetchAllEpisodes(id: id)

        return episodeResponse.map {
            Episode(id: String($0.id),
                    name: $0.name,
                    number: String($0.number),
                    season: String($0.season),
                    summary: Helper.removeHtmlTags(string: $0.summary),
                    image: Poster(imageUrl: $0.image?.medium ?? ""))
        }
    }
}
