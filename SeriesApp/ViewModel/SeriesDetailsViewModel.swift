//
//  SeriesDetailsViewModel.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

protocol SeriesDetailsViewModelProtocol {
    func fetchEpisodes(id: String) async
}

final class SeriesDetailsViewModel: ObservableObject, SeriesDetailsViewModelProtocol {
    @Published var state: ResponseState = .idle
    @Published var episodesList: [Episode] = []

    private let getAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol

    init(getAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol = GetAllEpisodesUseCase()) {
        self.getAllEpisodesUseCase = getAllEpisodesUseCase
    }

    @MainActor
    func fetchEpisodes(id: String) async {
        guard state != .loaded else {
            return
        }

        state = .loading
        do {
            episodesList = try await getAllEpisodesUseCase.getAllEpisodes(id: id)
            if !episodesList.isEmpty {
                self.episodesList = episodesList
                self.state = .loaded
                return
            }
            self.state = .error
        } catch {
            print(error)
            self.state = .error
        }
    }
}
