//
//  Remote.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import Foundation

class ApiCalling {
    let networkService = NetworkService.shared
    
    func callRestApi() {
        
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] ,let apiKey = Bundle.main.infoDictionary?["API_KEY"], let token = Bundle.main.infoDictionary?["ADMIN_TOKEN"],let key = Bundle.main.infoDictionary?["ADMIN_KEY"] else{
            return
        }
        
        let url = "https://\(apiKey):\(token)\(key)@\(baseURL)/admin/api/2022-01/collects.json"

        networkService.request(url: url, method: .GET , responseType: Test.self, completion: {
            result in
                switch result {
                case .success(let response):
                    print("Collects:", response)
                case .failure(let error):
                    print("Error:", error)
                }
        })

    }
}

