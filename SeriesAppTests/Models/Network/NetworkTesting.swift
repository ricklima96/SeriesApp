//
//  NetworkTesting.swift
//  SeriesAppTests
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import XCTest
@testable import SeriesApp

class NetworkTesting: XCTestCase {
    var sut: SeriesService?
    
    override func setUp() {
        super.setUp()
        sut = SeriesService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testRequestBuilding() async throws {
        let responseMock = [
            SeriesResponse(id: 1, name: "The Bear"),
            SeriesResponse(id: 2, name: "Friends") ]
        
        let apiManagerMock = ApiManagerMock(mockedResponse: responseMock)
        sut?.apiManager = apiManagerMock

        let requestURL = try sut?.buildRequest(SeriesListRequest(page: 1))
        XCTAssertNotNil(requestURL)
    }
    
    func testFetchAllSeries() async throws {
        let responseMock = [
            SeriesResponse(id: 1, name: "The Bear"),
            SeriesResponse(id: 2, name: "Friends") ]
        
        let apiManagerMock = ApiManagerMock(mockedResponse: responseMock)
        sut?.apiManager = apiManagerMock
        
        let series = try await sut?.fetchAllSeries(page: 1)
        
        XCTAssertEqual(series?.count, 2)
    }
    
    func testFetchSearchedSeries() async throws {
        let seriesMock = SeriesResponse(id: 1, name: "The Bear")
        let responseMock = [SearchSeriesResponse(show: seriesMock)]
        
        let apiManagerMock = ApiManagerMock(mockedResponse: responseMock)
        sut?.apiManager = apiManagerMock
        
        let searchResults = try await sut?.fetchSearchedSeries(query: "")
        
        XCTAssertEqual(searchResults?.count, 1)
    }
    
    func testFetchAllEpisodes() async throws {
        let responseMock = [
            EpisodeResponse(id: 1, name: "ep 1", number: 1, season: 1),
            EpisodeResponse(id: 2, name: "ep 2", number: 1, season: 1) ]
        
        let apiManagerMock = ApiManagerMock(mockedResponse: responseMock)
        sut?.apiManager = apiManagerMock
        
        let episodes = try await sut?.fetchAllEpisodes(id: "1")
        
        XCTAssertEqual(episodes?.count, 2)
    }
}


final class ApiManagerMock: ApiManagerProtocol {
    let mockedResponse: Decodable
    
    init(mockedResponse: Decodable) {
        self.mockedResponse = mockedResponse
    }
    
    func callApi<T: Decodable>(_: T.Type, urlRequest: URLRequest) async throws -> T {
        guard T.self == T.self else {
            throw NetworkError.dataRequestError("Unexpected type")
        }
        return mockedResponse as! T
    }
}

