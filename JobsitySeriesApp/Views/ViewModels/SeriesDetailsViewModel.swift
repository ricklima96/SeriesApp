//
//  SeriesDetailsViewModel.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import Foundation

protocol SeriesDetailsViewModelProtocol {
    func fetchEpisodes(id: String)
}

class SeriesDetailsViewModel: ObservableObject, SeriesDetailsViewModelProtocol {
    @Published var state: ResponseState = .idle
    @Published var episodesList: [Episode] = []
    private var paging = 0
    private var getAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol
    
    init(getAllEpisodesUseCase: GetAllEpisodesUseCaseProtocol = GetAllEpisodesUseCase()) {
        self.getAllEpisodesUseCase = getAllEpisodesUseCase
    }
    
    func fetchEpisodes(id: String) {
        state = .loading
        getAllEpisodesUseCase.getAllEpisodes(id: id) { result in
            switch result {
            case .success(let episodesList):
                if episodesList.count > 0 {
                    self.episodesList = episodesList
                    self.state = .loaded
                    return
                }
                self.state = .error
            case .failure(let error):
                print(error)
                self.state = .error
            }
        }
    }
}
