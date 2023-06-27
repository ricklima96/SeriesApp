//
//  SeriesViewModel.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

enum State {
    case idle
    case loading
    case loaded
    case error
}

protocol SeriesListViewModelProtocol {
    func fetchSeries() async
}

class SeriesListViewModel: ObservableObject, SeriesListViewModelProtocol {
    
    @Published var state: State = .idle
    @Published var series: [Serie] = []
    private var paging = 0
    
    func fetchSeries() {
        state = .loading
        SerieService.shared.fetchSeries() { result in
            switch result {
            case .success(let data):
                self.series = data
                self.state = .loaded
            case .failure(let error):
                self.state = .error
            }
        }
    }
    
    func fetchSeriesNextPage() {
        state = .loading
        SerieService.shared.fetchSeries() { result in
            switch result {
            case .success(let data):
                self.series = data
                self.state = .loaded
            case .failure(let error):
                self.state = .error
            }
        }
    }
}
