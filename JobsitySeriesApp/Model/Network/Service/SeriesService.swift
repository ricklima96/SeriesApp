//
//  SerieService.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

protocol SeriesServiceProtocol {
    func fetchAllSeries(page: Int) async throws -> [SeriesResponse]
    func fetchSearchedSeries(query: String) async throws -> [SearchSeriesResponse]
    func fetchAllEpisodes(id: String) async throws -> [EpisodeResponse]
}

final class SeriesService: SeriesServiceProtocol {

    func fetchAllSeries(page: Int) async throws -> [SeriesResponse] {
        let urlRequest = try buildRequest(with: SeriesListRequest(page: page))
        return try await ApiManager.shared.callApi(ofType: [SeriesResponse].self, urlRequest: urlRequest)
    }

    func fetchSearchedSeries(query: String) async throws -> [SearchSeriesResponse] {
        let urlRequest = try buildRequest(with: SearchSeriesRequest(query: query))
        return try await ApiManager.shared.callApi(ofType: [SearchSeriesResponse].self, urlRequest: urlRequest)
    }

    func fetchAllEpisodes(id: String) async throws -> [EpisodeResponse] {
        let urlRequest = try buildRequest(with: EpisodeRequest(id: id))
        return try await ApiManager.shared.callApi(ofType: [EpisodeResponse].self, urlRequest: urlRequest)
    }

    func buildRequest(with requestModel: RequestProtocol) throws -> URLRequest {
        let parameters = requestModel.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }

        var urlComponents = URLComponents(string: requestModel.url + requestModel.path)
        urlComponents?.queryItems = parameters

        guard let url = urlComponents?.url else {
            throw NetworkError.badUrl("bad url")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        urlRequest.httpMethod = requestModel.method

        return urlRequest
    }
}
