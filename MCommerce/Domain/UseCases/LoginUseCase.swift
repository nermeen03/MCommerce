//
//  LoginUseCase.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

import Foundation

struct LoginUseCase {
    private let repository: AuthenticationRepositoryProtocol
    
    init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
//    func getDiscount(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void) {
//        repository.getDiscounts(completion: completion)
//    }
    func login(email : String , password :String ,completion: @escaping (Result<CustomerAccessToken, NetworkError>) -> Void) {
        repository.login(email: email, password: password, completion: completion)
    }
    func getUserId(accessToken: String, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
        repository.getUserId(accessToken: accessToken, completion: completion)
    }
}
