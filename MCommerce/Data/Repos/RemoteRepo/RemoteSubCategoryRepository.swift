//
//  RemoteSubCategoryRepository.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import Foundation

final class RemoteSubCategoryRepository: SubCategoryRepositoryProtocol {
    private let api: ApiCalling

    init(api: ApiCalling = ApiCalling()) {
        self.api = api
    }

    func fetchSubCategories(completion: @escaping (Result<[SubCategory], NetworkError>) -> Void) {
        let query = """
        {
          collections(first: 100) {
            edges {
              node {
                title
                handle
              }
            }
          }
        }
        """

        api.callQueryApi(query: query, completion: { (result: Result<SubCategoryResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let all = response.data.collections.edges.map { $0.node }
                let subcategories = all.filter { $0.title.contains(" | ") }.map { node in
                    let parts = node.title.components(separatedBy: " | ")
                    let parent = parts.first ?? ""
                    return node.toDomain(parentTitle: parent)
                }
                completion(.success(subcategories))

            case .failure(let error):
                print("Failed to fetch subcategories:", error)
                completion(.failure(error))
            }
        })
    }
}
