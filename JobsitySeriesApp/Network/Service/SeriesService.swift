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
    private var searchUrl = "https://api.tvmaze.com/search/shows"
    private var episodesPath = "/episodes"

    func fetchAllSeries(page: Int, completionHandler: @escaping (Result<[SeriesResponse], Error>) -> Void) {
        var seriesUrl = URLComponents(string: baseUrl)!
        let parameters = [URLQueryItem(name: "page", value: String(page))]
        seriesUrl.queryItems = parameters
         
        var urlRequest = URLRequest(url: seriesUrl.url!)
        urlRequest.httpMethod = "GET"
        
        ApiManager.shared.callApi(ofType: [SeriesResponse].self, url: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchSearchedSeries(query: String, completionHandler: @escaping (Result<[SearchResponse], Error>) -> Void) {
        var searchsUrl = URLComponents(string: searchUrl)!
        let parameters = [URLQueryItem(name: "q", value: query)]
        searchsUrl.queryItems = parameters
         
        var urlRequest = URLRequest(url: searchsUrl.url!)
        urlRequest.httpMethod = "GET"
                
        ApiManager.shared.callApi(ofType: [SearchResponse].self, url: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchAllEpisodes(id: String, completionHandler: @escaping (Result<[EpisodeResponse], Error>) -> Void) {
        let searchsUrl = URLComponents(string: baseUrl + "/" + (id) + episodesPath)!
        
        var urlRequest = URLRequest(url: searchsUrl.url!)
        urlRequest.httpMethod = "GET"
                        
        ApiManager.shared.callApi(ofType: [EpisodeResponse].self, url: urlRequest) { response in
            switch response {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
