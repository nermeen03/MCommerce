//
//  SubCategoryRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

protocol SubCategoryRepositoryProtocol {
    func fetchSubCategories(completion: @escaping (Result<[SubCategory], NetworkError>) -> Void)
}
