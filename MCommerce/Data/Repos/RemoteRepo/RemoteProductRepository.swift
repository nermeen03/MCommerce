// RemoteProductRepository.swift
// MCommerce
// Created by abram on 19/06/2025.

import Foundation

final class RemoteProductRepository: ProductRepositoryProtocol {
    private let api: ApiCalling

    init(api: ApiCalling = ApiCalling()) {
        self.api = api
    }

    func fetchCollections(completion: @escaping (Result<[CollectionDTO], NetworkError>) -> Void) {
        let query = """
        {
          collections(first: 20) {
            edges {
              node {
                title
                handle
              }
            }
          }
        }
        """

        api.callQueryApi(query: query, completion: { (result: Result<CollectionResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let allowedHandles = ["women", "men", "kid", "sale"]

                let collections = response.data.collections.edges
                    .map { $0.node }
                    .filter { allowedHandles.contains($0.handle.lowercased()) }
                    .map { node in
                        print(" Found collection — Title: \(node.title), Handle: \(node.handle)")
                        return CollectionDTO(title: node.title, handle: node.handle)
                    }

                completion(.success(collections))

            case .failure(let error):
                print(" Failed to fetch collections:", error)
                completion(.failure(error))
            }
        })
    }

    func fetchProducts(inCollectionHandle handle: String, completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void) {
        let query = """
        {
          collectionByHandle(handle: "\(handle)") {
            title
            products(first: 20) {
              edges {
                node {
                  id
                  title
                  description
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
        }
        """


        print("🔍 Fetching products with handle: \(handle)")

        api.callQueryApi(query: query, completion: { (result: Result<ProductResponse, NetworkError>) in
            switch result {
            case .success(let response):
                guard let collection = response.data.collectionByHandle else {
                    print(" collectionByHandle is null for handle: \(handle)")
                    completion(.success([]))
                    return
                }

                let brandName = collection.title
                let products = collection.products.edges.map { edge in
                    let node = edge.node
                    return BrandProduct(
                        id: node.id,
                        title: node.title,
                        description: node.description,
                        imageUrl: node.images.edges.first?.node.originalSrc ?? "",
                        price: Double(node.variants.edges.first?.node.price.amount ?? "0") ?? 0.0,
                        brandName: brandName
                    )
                }
                completion(.success(products))
            case .failure(let error):
                print(" Failed to fetch products:", error)
                completion(.failure(error))
            }
        })
    }
}
