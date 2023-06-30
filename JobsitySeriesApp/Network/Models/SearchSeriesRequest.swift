//
//  SearchSeriesRequest.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import Foundation

struct SearchSeriesRequest: RequestProtocol {
    var query: String
    var url: String { return "https://api.tvmaze.com" }
    var path: String { return "/search/shows" }
    var method: String { return "GET" }
    var queryParameters: [String : String]? { return ["q": self.query] }
}
