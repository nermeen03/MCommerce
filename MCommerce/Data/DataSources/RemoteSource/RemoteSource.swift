//
//  Remote.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import Foundation
import Alamofire

struct ApiCalling : RemoteServicesProtocol{
    let networkService = NetworkService.shared
    
    func callRestApi(parameters : [String: Any], method : HTTPMethod = .POST, json:String) {
        
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ,let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"] else{
            return
        }
        
        let url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/\(json).json"
        networkService.request(url: url, method: method, parameters: parameters, responseType: Test.self, completion: {
            result in
                switch result {
                case .success(let response):
                    print("Collects:", response)
                case .failure(let error):
                    print("Error:", error)
                }
        })

    }
    
    func callQueryApi<T: Decodable>(query: String, variables: [String: Any]? = nil, useToken : Bool = false, completion : @escaping (Result<T, NetworkError>) -> Void) {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let storefrontToken = Bundle.main.infoDictionary?["STOREFRONT_API"] as? String,
        let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"]else {
            return
        }
        
        let url : String
        if !useToken {
            url = "https://\(baseURL)/api/2022-01/graphql.json"
        }else{
            url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/graphql.json"
        }

        let headers: [String: String] = [
            "Content-Type": "application/json",
            "X-Shopify-Storefront-Access-Token": storefrontToken
        ]
       
       networkService.request(
           url: url,
           method: .POST,
           headers: headers,
           graphQLQuery: query,
           variables: variables,
           responseType: T.self
       ) { result in
           completion(result)
           switch result {
           case .success(let response):
               print("GraphQL Response:", response)
           case .failure(let error):
               print("GraphQL Error:", error)
           }
       }
    }
}

