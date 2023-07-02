//
//  EpisodeRequest.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import Foundation

struct EpisodeRequest: RequestProtocol {
    var id: String
    var url: String { "https://api.tvmaze.com" }
    var path: String { "/shows/\(id)/episodes" }
    var method: String { "GET" }
    var queryParameters: [String: String]? { nil }
}
