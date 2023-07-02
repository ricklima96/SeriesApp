//
//  SearchViewModel.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

protocol SearchSeriesViewModelProtocol {
    func fetchSearchedSerie(query: String) async
}

final class SearchSeriesViewModel: ObservableObject, SearchSeriesViewModelProtocol {
    @Published var state: ResponseState = .idle
    @Published var seriesList: [Series] = []
    @Published var query: String = ""

    private let getSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol

    init(getSearchedSeriesUseCase: GetSearchedSeriesUseCaseProtocol = GetSearchedSeriesUseCase()) {
        self.getSearchedSeriesUseCase = getSearchedSeriesUseCase
    }

    @MainActor
    func fetchSearchedSerie(query: String) async {
        state = .loading
        do {
            seriesList = try await getSearchedSeriesUseCase.getSearchedSeries(query: query)
            if !seriesList.isEmpty {
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
