//
//  ApiManager.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import Foundation
import Alamofire

public class ApiManager {
    
    public static let shared = ApiManager()
    
    func callApi(endpoint: String, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parameters: Parameters? = nil,
                 completionHandler: @escaping (Result<Data?, Error>) -> Void) {
        
        if let url = URLComponents(string: "\(endpoint)") {
            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    if response.error != nil {
                        completionHandler(.failure(response.error!))
                    } else {
                        completionHandler(.success(response.data))
                    }
                }
        }
    }
}
