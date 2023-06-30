//
//  SerieService.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct SeriesService {
    public static let shared = SeriesService()
    
    func fetchAllSeries(page: Int, completionHandler: @escaping (Result<[SeriesResponse], Error>) -> Void) {
        let urlRequest = buildRequest(with: SeriesRequest(page: page))
        
        ApiManager.shared.callApi(ofType: [SeriesResponse].self, urlRequest: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchSearchedSeries(query: String, completionHandler: @escaping (Result<[SearchSeriesResponse], Error>) -> Void) {
        let urlRequest = buildRequest(with: SearchSeriesRequest(query: query))

        ApiManager.shared.callApi(ofType: [SearchSeriesResponse].self, urlRequest: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchAllEpisodes(id: String, completionHandler: @escaping (Result<[EpisodeResponse], Error>) -> Void) {
        let urlRequest = buildRequest(with: EpisodeRequest(id: id))
        
        ApiManager.shared.callApi(ofType: [EpisodeResponse].self, urlRequest: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
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
