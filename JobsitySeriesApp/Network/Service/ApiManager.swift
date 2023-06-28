//
//  ApiManager.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 28/06/23.
//

import Foundation

struct ApiManager {
    public static let shared = ApiManager()
    
    func callApi<T: Decodable>(ofType: T.Type, url: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(.success(decodedResponse))
                    }
                    return
                }
            }
            completionHandler(.failure(error!))
        }.resume()
    }
}
