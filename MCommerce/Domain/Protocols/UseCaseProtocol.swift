//
//  UseCaseProtocol.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

protocol DiscountsUseCaseProtocol {
    func getDiscount(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void)
}
