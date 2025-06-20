//
//  RemoteSubCategoryRepository.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import Foundation

import Foundation

final class RemoteSubCategoryRepository: SubCategoryRepositoryProtocol {
    private let api: ApiCalling

    init(api: ApiCalling = ApiCalling()) {
        self.api = api
    }

    func fetchSubCategories(forCollectionHandle handle: String, parentTitle: String, completion: @escaping (Result<[SubCategory], NetworkError>) -> Void) {
        let query = """
        {
          products(first: 50, query: "collection_handle:\(handle)") {
            edges {
              node {
                id
                title
                handle
                productType
              }
            }
          }
        }
        """

        api.callQueryApi(query: query) { (result: Result<SubCategoryResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let products = response.data.products.edges.map { $0.node }
                let uniqueTypes = Dictionary(grouping: products, by: \.productType).compactMapValues { $0.first }
                let subcategories = uniqueTypes.map { $0.value.toDomain(parentTitle: parentTitle) }
                completion(.success(subcategories))
            case .failure(let error):
                print("Failed to fetch subcategories:", error)
                completion(.failure(error))
            }
        }
    }

    func fetchProductsBySubCategory(forCollectionHandle handle: String, productType: String, completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void) {
        let query = """
        {
          products(first: 20, query: "collection_handle:\(handle) AND product_type:\(productType)") {
            edges {
              node {
                id
                title
                description
                productType
                images(first: 1) {
                  edges {
                    node {
                      originalSrc
                    }
                  }
                }
                variants(first: 1) {
                  edges {
                    node {
                      price {
                        amount
                        currencyCode
                      }
                    }
                  }
                }
              }
            }
          }
        }
        """

        api.callQueryApi(query: query) { (result: Result<ProductResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let products = response.data.products?.edges.map { $0.node.toDomain() } ?? []
                completion(.success(products))
            case .failure(let error):
                print("Failed to fetch products:", error)
                completion(.failure(error))
            }
        }
    }
}
