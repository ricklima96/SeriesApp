//
//  SerieService.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation
import Alamofire

struct SerieService {
    public static let shared = SerieService()
    private let seriesUrl = "https://api.tvmaze.com/shows"
        
    func fetchSeries(parameters: Parameters? = nil, completionHandler: @escaping (Result<[Serie], Error>) -> Void) {
        ApiManager.shared.callApi(endpoint: seriesUrl, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let serieResponse = try JSONDecoder().decode([Serie].self, from: data)
                        completionHandler(.success(serieResponse))
                    }
                } catch {
                    print(error)
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}
