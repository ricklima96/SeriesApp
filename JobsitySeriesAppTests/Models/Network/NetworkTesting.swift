//
//  NetworkTesting.swift
//  SeriesAppTests
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import XCTest
@testable import SeriesApp

final class NetworkTesting: XCTestCase {
    
//    var sut: SeriesService
//    
//    override func setUp() {
//        super.setUp()
//        seriesService = SeriesService()
//    }
//    
//    override func tearDown() {
//        seriesService = nil
//        super.tearDown()
//    }
//    
//    func testRequestBuilding() async throws {
//
//        let requestURL = try sut.buildRequest(with: SeriesListRequest(page: 1))
//        XCTAssertNotNil(requestURL)
//    }
//    
//    func testFetchAllSeries() {
//        let id = "1"
//        let expectedResponse = [ SeriesResponse(id: 1, name: "Friends"),
//                                 SeriesResponse(id: 2, name: "The Bear") ]
//        
//        let mockApiManager = MockApiManager(mockedResponse: expectedResponse)
//        sut. = mockApiManager
//        
//    }

    
}


final class MockApiManager {
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

