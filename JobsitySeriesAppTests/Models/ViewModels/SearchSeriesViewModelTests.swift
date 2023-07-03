//
//  SearchSeriesViewModelTests.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 02/07/23.
//

import Foundation
import XCTest
@testable import SeriesApp

class SearchSeriesViewModelTests: XCTestCase {
    func testFetchSearchedSerie_responseSuccess() async throws {
        let getSearchedSeriesUseCase = SearchedSeriesUseCaseProtocolMock(successful: true)
        let viewModel = SearchSeriesViewModel(getSearchedSeriesUseCase: getSearchedSeriesUseCase)

        await viewModel.fetchSearchedSerie(query: "")

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertNotNil(viewModel.query)
        XCTAssertFalse(viewModel.seriesList.isEmpty)
    }

    func testFetchSearchedSerie_responseFailure() async throws {
        let  getSearchedSeriesUseCase = SearchedSeriesUseCaseProtocolMock(successful: false)
        let viewModel = SearchSeriesViewModel(getSearchedSeriesUseCase: getSearchedSeriesUseCase)

        await viewModel.fetchSearchedSerie(query: "")

        XCTAssertEqual(viewModel.state, .error)
        XCTAssertNotNil(viewModel.query)
        XCTAssertTrue(viewModel.seriesList.isEmpty)
    }
}

class SearchedSeriesUseCaseProtocolMock: GetSearchedSeriesUseCaseProtocol {

    var successful: Bool

    init(successful: Bool) {
        self.successful = successful
    }

    func getSearchedSeries(query: String) async throws -> [Series] {
        if successful {
            return [
                Series(id: "1",
                       rating: "10",
                       name: "Friends",
                       image: Poster(imageUrl: ""),
                       schedule: Schedule(time: "", days: []),
                       genres: [],
                       summary: ""),
                Series(id: "2",
                       rating: "10",
                       name: "The Bear",
                       image: Poster(imageUrl: ""),
                       schedule: Schedule(time: "", days: []),
                       genres: [],
                       summary: "")
            ]
        } else {
            throw NetworkError.dataRequestError("failure")
        }
    }
}
