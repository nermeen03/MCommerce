//
//  ProductRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

protocol ProductRepositoryProtocol {
    func fetchCollections(completion: @escaping (Result<[CollectionDTO], NetworkError>) -> Void)
    func fetchProducts(inCollectionHandle handle: String, completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void)
}
