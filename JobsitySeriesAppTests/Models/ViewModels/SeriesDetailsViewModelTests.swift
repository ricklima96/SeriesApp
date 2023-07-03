//
//  SeriesDetailsViewModelTests.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 02/07/23.
//

import Foundation
import XCTest
@testable import SeriesApp

class SeriesDetailsViewModelTests: XCTestCase {
    func testFetchEpisodes_responseSuccess() async throws {
        let getSearchedSeriesUseCase = GetAllEpisodesUseCaseProtocolMock(successful: true)
        let viewModel = SeriesDetailsViewModel(getAllEpisodesUseCase: getSearchedSeriesUseCase)

        await viewModel.fetchEpisodes(id: "1")

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.episodesList.isEmpty)
    }

    func testFetchEpisodes_responseFailure() async throws {
        let  getSearchedSeriesUseCase = GetAllEpisodesUseCaseProtocolMock(successful: false)
        let viewModel = SeriesDetailsViewModel(getAllEpisodesUseCase: getSearchedSeriesUseCase)

        await viewModel.fetchEpisodes(id: "1")

        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.episodesList.isEmpty)
    }
}

class GetAllEpisodesUseCaseProtocolMock: GetAllEpisodesUseCaseProtocol {
    var successful: Bool

    init(successful: Bool) {
        self.successful = successful
    }

    func getAllEpisodes(id: String) async throws -> [Episode] {
        if successful {
            return [
                Episode(id: "1",
                        name: "Ep 1",
                        number: "1",
                        season: "1",
                        summary: "lorem ipsum",
                        image: Poster(imageUrl: "")),
                Episode(id: "2",
                        name: "Ep 2",
                        number: "2",
                        season: "1",
                        summary: "lorem ipsum",
                        image: Poster(imageUrl: ""))
            ]
        } else {
            throw NetworkError.dataRequestError("failure")
        }
    }
}
