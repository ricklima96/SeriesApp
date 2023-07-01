//
//  NetworkTesting.swift
//  JobsitySeriesAppTests
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import XCTest
@testable import JobsitySeriesApp

final class NetworkTesting: XCTestCase {
    
    private let sut = SeriesService()

    func testRequestBuilding() async throws {
    
        let requestURL = try sut.buildRequest(with: SeriesListRequest(page: 1))
        XCTAssertNotNil(requestURL)
    }
    
    func testFetchAllSeries() async throws {

        let series = try await sut.fetchAllSeries(page: 1)
        
        XCTAssertNotNil(series)
        XCTAssertTrue(series.count > 0)
        XCTAssertTrue(!series.isEmpty)
    }

    
    func testFetchSearchedSeries() async throws {
        let series = try await sut.fetchSearchedSeries(query: "Friends")
        
        XCTAssertNotNil(series)
        XCTAssertTrue(series.count > 0)
        XCTAssertTrue(!series.isEmpty)
    }

    
    func testFetchAllEpisodes() async throws {
        let serepisodesies = try await sut.fetchAllEpisodes(id: "1")
        
        XCTAssertNotNil(serepisodesies)
        XCTAssertTrue(serepisodesies.count > 0)
        XCTAssertTrue(!serepisodesies.isEmpty)
    }
}
