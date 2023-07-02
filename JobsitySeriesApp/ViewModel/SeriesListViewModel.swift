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
    func fetchSeries() async
    func fetchSeriesNextPage() async
}

final class SeriesListViewModel: ObservableObject, SeriesListViewModelProtocol {
    @Published var state: ResponseState = .idle
    @Published var seriesList: [Series] = []
    private let getAllSeriesUseCase: GetAllSeriesUseCaseProtocol
    private var page = 0

    init(getAllSeriesUseCase: GetAllSeriesUseCaseProtocol = GetAllSeriesUseCase()) {
        self.getAllSeriesUseCase = getAllSeriesUseCase
    }

    @MainActor
    func fetchSeries() async {
        guard state != .loaded else {
            return
        }

        state = .loading
        do {
            seriesList = try await getAllSeriesUseCase.getAllSeries(page: page)
            if !seriesList.isEmpty {
                self.seriesList = seriesList
                self.state = .loaded
                return
            }
            self.state = .error
        } catch {
            print(error)
            self.state = .error
        }
    }

    func recheadEndOfPage(series: Series) -> Bool {
        return seriesList.last?.id == series.id
    }

    @MainActor
    func fetchSeriesNextPage() async {
        page += 1
        do {
            let nextPageSeriesList = try await getAllSeriesUseCase.getAllSeries(page: page)
            self.seriesList.append(contentsOf: nextPageSeriesList)
        } catch {
            print(error)
            self.state = .error
        }
    }
}
