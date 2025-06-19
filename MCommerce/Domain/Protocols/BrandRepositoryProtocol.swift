//
//  BrandRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//

protocol BrandRepositoryProtocol {
    func fetchBrands(completion: @escaping (Result<[Brand], NetworkError>) -> Void)
}
