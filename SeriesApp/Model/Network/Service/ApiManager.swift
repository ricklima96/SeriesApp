//
//  ApiManager.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 28/06/23.
//

import Foundation

enum NetworkError: Error {
    case dataRequestError(String)
    case badUrl(String)
}

protocol ApiManagerProtocol {
    func callApi<T: Decodable>(_: T.Type, urlRequest: URLRequest) async throws -> T
}

class ApiManager: ApiManagerProtocol {
    
    func callApi<T: Decodable>(_: T.Type, urlRequest: URLRequest) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.dataRequestError("Error from API call.")
        }
    }
}
