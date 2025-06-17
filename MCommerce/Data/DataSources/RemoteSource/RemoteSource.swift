//
//  Remote.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import Foundation
import Alamofire

class ApiCalling {
    let networkService = NetworkService.shared
    func createCustomer() {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ,let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"] else{
            return
        }
        
        let url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/customers.json"
          
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]

            let parameters: [String: Any] = [
                "customer": [
                    "first_name": "Nermeen",
                    "id" : "1024064673",
                    "last_name": "Mohamed",
                    "email": "nermeennnn55@gmail.com",
                    "phone": "+201234567840",
                    "verified_email": true,
                    "password": "YourSecurePassword12@",
                    "password_confirmation": "YourSecurePassword12@",
                    "accepts_marketing": true
                ]
            ]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print("✅ Customer created: \(value)")
                    case .failure(let error):
                        print("❌ Error: \(error)")
                    }
                }
        }
    
//    func callRestApi(parameters : [String: Any], method : HTTPMethod = .POST, json:String) {
//        
//        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ,let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"] else{
//            return
//        }
//        
//
//        let url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/collects.json"
//        print(url)
//
//        networkService.request(url: url, method: .GET , responseType: Test.self, completion: {
//
//            result in
//                switch result {
//                case .success(let response):
//                    print("Collects:", response)
//                case .failure(let error):
//                    print("Error:", error)
//                }
//        })
//
//    }
    
    func callQueryApi(query: String, variables: [String: Any]) {
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let storefrontToken = Bundle.main.infoDictionary?["STOREFRONT_API"] as? String else {
            return
        }
        
        let url = "https://\(baseURL)/api/2022-01/graphql.json"
        
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
           responseType: Test.self
           
       ) { result in
           switch result {
           case .success(let response):
               print("GraphQL Response:", response)
           case .failure(let error):
               print("GraphQL Error:", error)
           }
       }
    }
}

