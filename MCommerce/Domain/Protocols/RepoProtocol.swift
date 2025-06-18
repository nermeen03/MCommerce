//
//  Protocol.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

protocol DiscountRepositoryProtocol {
    func getDiscounts(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void)
}
protocol AuthenticationRepositoryProtocol {
    func register(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void)
    func login(email: String, password: String, completion: @escaping (Result<CustomerAccessToken, NetworkError>) -> Void)
    func getUserId(accessToken: String, completion: @escaping (Result<Customer, NetworkError>) -> Void) 
}
