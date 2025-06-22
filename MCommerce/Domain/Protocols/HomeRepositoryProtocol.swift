//
//  BrandRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//

protocol HomeRepositoryProtocol {
    func fetchBrands(completion: @escaping (Result<[Brand], NetworkError>) -> Void)
    func fetchAllProducts(num : Int ,completion: @escaping (Result<[Product], NetworkError>) -> Void)
}
