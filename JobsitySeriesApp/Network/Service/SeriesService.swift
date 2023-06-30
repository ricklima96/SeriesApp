//
//  SerieService.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct SeriesService {
    public static let shared = SeriesService()
    
    func fetchAllSeries(page: Int) async throws -> [SeriesResponse] {
        let urlRequest = buildRequest(with: SeriesRequest(page: page))
        return try await ApiManager.shared.callApi(ofType: [SeriesResponse].self, urlRequest: urlRequest)
    }
    
    func fetchSearchedSeries(query: String) async throws -> [SearchSeriesResponse] {
        let urlRequest = buildRequest(with: SearchSeriesRequest(query: query))
        return try await ApiManager.shared.callApi(ofType: [SearchSeriesResponse].self, urlRequest: urlRequest)
    }
    
    func fetchAllEpisodes(id: String) async throws -> [EpisodeResponse] {
        let urlRequest = buildRequest(with: EpisodeRequest(id: id))
        return try await ApiManager.shared.callApi(ofType: [EpisodeResponse].self, urlRequest: urlRequest)
    }
    
    func buildRequest(with requestModel: RequestProtocol) -> URLRequest {
        let parameters = requestModel.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: requestModel.url + requestModel.path)
        urlComponents?.queryItems = parameters
        
        guard let url = urlComponents?.url else {
            print("bad url")
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        urlRequest.httpMethod = requestModel.method
        
        return urlRequest
    }
}
