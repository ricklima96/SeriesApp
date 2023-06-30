//
//  SeriesRequest.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var path: String { get }
    var method: String { get }
    var queryParameters: [String: String]? { get }
}

struct SeriesListRequest: RequestProtocol {
    var page: Int
    var url: String { return "https://api.tvmaze.com" }
    var path: String { return "/shows" }
    var method: String { return "GET" }
    var queryParameters: [String : String]? { return ["page": String(self.page)] }
}
