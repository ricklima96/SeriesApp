//
//  EpisodeRequest.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import Foundation

struct EpisodeRequest: RequestProtocol {
    var id: String
    var url: String { return "https://api.tvmaze.com" }
    var path: String { return "/shows/\(id)/episodes" }
    var method: String { return "GET" }
    var queryParameters: [String: String]? { return nil }
}
