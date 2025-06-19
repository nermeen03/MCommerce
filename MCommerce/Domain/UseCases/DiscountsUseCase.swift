//
//  DiscountsUserCase.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

struct DiscountsUseCase : DiscountsUseCaseProtocol{
    private let repository: DiscountRepositoryProtocol
    
    init(repository: DiscountRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDiscount(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void) {
        repository.getDiscounts(completion: completion)
    }
}

