//
//  SeriesViewModel.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

enum ResponseState {
    case idle
    case loading
    case loaded
    case error
}

protocol SeriesListViewModelProtocol {
    func fetchSeries()
}

class SeriesListViewModel: ObservableObject, SeriesListViewModelProtocol {
    @Published var state: ResponseState = .idle
    @Published var seriesList: [Series] = []
    private var paging = 0
    private var getAllSeriesUseCase: GetAllSeriesUseCaseProtocol
    
    init(getAllSeriesUseCase: GetAllSeriesUseCaseProtocol = GetAllSeriesUseCase()) {
        self.getAllSeriesUseCase = getAllSeriesUseCase
    }
    
    func fetchSeries() {
        state = .loading
        getAllSeriesUseCase.getAllSeries(page: paging) { result in
            switch result {
            case .success(let seriesList):
                self.seriesList = seriesList
                self.state = .loaded
            case .failure(let error):
                print(error)
                self.state = .error
            }
        }
    }
    
    func recheadEndOfPage(series: Series) -> Bool {
        return seriesList.last?.id == series.id
    }
    
    func fetchSeriesNextPage() {
        paging += 1
        getAllSeriesUseCase.getAllSeries(page: paging) { result in
            switch result {
            case .success(let nextPageSeries):
                self.seriesList.append(contentsOf: nextPageSeries)
            case .failure(let error):
                print(error)
                self.state = .error
            }
        }
    }
    
}
