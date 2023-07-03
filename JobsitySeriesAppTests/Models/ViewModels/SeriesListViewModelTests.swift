//
//  SeriesListViewModelTests.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 02/07/23.
//

import Foundation
import XCTest
@testable import SeriesApp

class SeriesListViewModelTests: XCTestCase {
    func testFetchSeries_responseSuccess() async throws {
        let getAllSeriesUseCase = GetAllSeriesUseCaseMock(successful: true)
        let viewModel = SeriesListViewModel(getAllSeriesUseCase: getAllSeriesUseCase)

        await viewModel.fetchSeries()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.seriesList.isEmpty)
    }

    func testFetchSeries_responseFailure() async throws {
        let getAllSeriesUseCase = GetAllSeriesUseCaseMock(successful: false)
        let viewModel = SeriesListViewModel(getAllSeriesUseCase: getAllSeriesUseCase)

        await viewModel.fetchSeries()

        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.seriesList.isEmpty)
    }
}

class GetAllSeriesUseCaseMock: GetAllSeriesUseCaseProtocol {

    var successful: Bool

    init(successful: Bool) {
        self.successful = successful
    }

    func getAllSeries(page: Int) async throws -> [Series] {
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
