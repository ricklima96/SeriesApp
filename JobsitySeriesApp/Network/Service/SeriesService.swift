//
//  SerieService.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation

struct SeriesService {
    public static let shared = SeriesService()
    private var baseUrl = "https://api.tvmaze.com/shows"
    
    func fetchAllSeries(page: Int, completionHandler: @escaping (Result<[SerieResponse], Error>) -> Void) {
        var seriesUrl = URLComponents(string: baseUrl)!
        let parameters = [URLQueryItem(name: "page", value: String(page))]
        seriesUrl.queryItems = parameters
         
        var urlRequest = URLRequest(url: seriesUrl.url!)
        urlRequest.httpMethod = "GET"
        
        ApiManager.shared.callApi(ofType: [SerieResponse].self, url: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchSearchedSeries(query: String, completionHandler: @escaping (Result<[SerieResponse], Error>) -> Void) {
        var seriesUrl = URLComponents(string: baseUrl)!
        let parameters = [URLQueryItem(name: "q", value: query)]
        seriesUrl.queryItems = parameters
         
        var urlRequest = URLRequest(url: seriesUrl.url!)
        urlRequest.httpMethod = "GET"
        
        ApiManager.shared.callApi(ofType: [SerieResponse].self, url: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
