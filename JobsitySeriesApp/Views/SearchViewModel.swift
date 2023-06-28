//
//  SearchViewModel.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

protocol SearchViewModelProtocol {
    func fetchSearchedSerie(query: String)
}

class SearchViewModel: ObservableObject, SearchViewModelProtocol {
    
    @Published var state: ResponseState = .idle
    @Published var series: [Series] = []
    @Published var query: String = ""
    private var getSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol
    
    init(getSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol = GetSearchedSeriesUseCase()) {
        self.getSearchedSeriesUseCase = getSearchedSeriesUseCase
    }
    
    func fetchSearchedSerie(query: String) {
        state = .loading
        getSearchedSeriesUseCase.getSearchedSeries(query: query) { result in
            switch result {
            case .success(let series):
                self.series = series
                self.state = .loaded
            case .failure(let error):
                print(error)
                self.state = .error
            }
        }
    }
    
}


