//
//  BrandDetailRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

protocol BrandDetailsRepositoryProtocol {
    func fetchProducts(for brand: Brand, completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void)
}
