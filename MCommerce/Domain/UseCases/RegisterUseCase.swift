//
//  RegisterUseCase.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

struct RegisterUseCase {
    private let repository: AuthenticationRepositoryProtocol
    
    init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }
    
//    func getDiscount(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void) {
//        repository.getDiscounts(completion: completion)
//    }
    func register(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
        repository.register(user: user, completion: completion)
    }
}
