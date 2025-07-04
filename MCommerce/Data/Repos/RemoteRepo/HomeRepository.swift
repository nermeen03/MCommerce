//
//  BrandRepository.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//
class HomeRepository: HomeRepositoryProtocol {
    private let service: RemoteServicesProtocol

    init(service: RemoteServicesProtocol) {
        self.service = service
    }

    func fetchBrands(completion: @escaping (Result<[Brand], NetworkError>) -> Void) {
        let query = """
        {
          collections(first: 13) {
            edges {
              node {
                id
                title
                image {
                  url
                }
              }
            }
          }
        }
        """

        service.callQueryApi(query: query, variables: nil, useToken: false, completion: { (result: Result<BrandsResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let brands = response.data.collections.edges
                    .dropFirst()
                    .map {
                    Brand(id: $0.node.id, title: $0.node.title, imageUrl: $0.node.image?.url)
                }
                completion(.success(brands))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    func fetchAllProducts(num : Int , completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        let query = """
        {
          products(first: \(num)) {
            edges {
              node {
                id
                title
                description
                vendor
                images(first: 5) {
                  edges {
                    node {
                      url
                    }
                  }
                }
                variants(first: 5) {
                  edges {
                    node {
                      id
                      price {
                        amount
                      }
                    }
                  }
                }
              }
            }
          }
        }
        """

        service.callQueryApi(query: query, variables: nil, useToken: false, completion: { (result: Result<GraphQLProductResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let products = response.data.products.edges.map { $0.node }.map {
                    Product(
                        id: $0.id,
                        title: $0.title,
                        imageUrl: $0.images.edges.first?.node.url,
                        price: Double($0.variants.edges.first?.node.price.amount ?? "") ?? 0.0
                    )
                }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}
