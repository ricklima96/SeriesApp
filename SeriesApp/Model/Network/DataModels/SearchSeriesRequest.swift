//
//  SearchSeriesRequest.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import Foundation

struct SearchSeriesRequest: RequestProtocol {
    var query: String
    var url: String { "https://api.tvmaze.com" }
    var path: String { "/search/shows" }
    var method: String { "GET" }
    var queryParameters: [String: String]? { ["q": self.query] }
}
