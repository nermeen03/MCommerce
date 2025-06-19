//
//  NetworkService.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
    
    var afMethod: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: self.rawValue)
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case custom(message: String)

}

final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .POST,
        headers: [String: String] = [:],
        parameters: [String: Any]? = nil,
        graphQLQuery: String? = nil,
        variables: [String: Any]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var body: [String: Any]?
        
        if let graphQLQuery = graphQLQuery {
            body = ["query": graphQLQuery]
            if let variables = variables {
                body?["variables"] = variables
            }
        } else if let parameters = parameters {
            body = parameters

        }

        var updatedHeaders = headers
        if updatedHeaders["Content-Type"] == nil {
            updatedHeaders["Content-Type"] = "application/json"
        }

        let afHeaders = HTTPHeaders(updatedHeaders)

        AF.request(
            endpoint,
            method: method.afMethod,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: afHeaders
        )
        .validate()
        .responseData { response in
            if let data = response.data,
               let jsonString = String(data: data, encoding: .utf8) {
                print("RAW RESPONSE: \(jsonString)")
            }
        }

        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decoded):
                completion(.success(decoded))
            case .failure(let error):
                if let data = response.data {
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                } else {
                    completion(.failure(.requestFailed(error)))
                }
            }
        }
    }
}
