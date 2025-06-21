//
//  SubCategoryRepositoryProtocol.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

protocol SubCategoryRepositoryProtocol {
    func fetchSubCategories(
        forCollectionHandle handle: String,
        parentTitle: String,
        completion: @escaping (Result<[SubCategory], NetworkError>) -> Void
    )
    
    func fetchProductsBySubCategory(
        forCollectionHandle handle: String,
        productType: String,
        completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void
    )
}

