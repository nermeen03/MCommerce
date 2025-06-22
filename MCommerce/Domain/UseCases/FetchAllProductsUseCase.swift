//
//  FetchAllProductsUseCase.swift
//  MCommerce
//
//  Created by Jailan Medhat on 21/06/2025.
//

import Foundation
class FetchAllProductsUseCase {
    let repo : HomeRepositoryProtocol
    init(repo: HomeRepositoryProtocol) {
        self.repo = repo
    }
    func execute(num : Int ,completion: @escaping (Result<[Product], NetworkError>) -> Void){
        repo.fetchAllProducts(num : num ,  completion: completion)
        
    }
}
