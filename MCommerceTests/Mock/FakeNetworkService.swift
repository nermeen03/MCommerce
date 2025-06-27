//
//  FakeNetworkService.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 28/06/2025.
//

import Foundation
@testable import MCommerce

class FakeNetworkServices{
    var shouldFail : Bool
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
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
        if shouldFail {
            completion(.failure(.invalidURL))
        } else {
            if let response = TestClass() as? T {
                completion(.success(response))
            } else {
                completion(.failure(.invalidResponse))
            }
        }
    }
}

class TestClass : Codable {
    
}
