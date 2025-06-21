//
//  BrandDetailsRepository.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

final class BrandDetailsRepository: BrandDetailsRepositoryProtocol {
    private let api = ApiCalling()

    func fetchProducts(for brand: Brand, completion: @escaping (Result<[BrandProduct], NetworkError>) -> Void) {
        let query = """
        {
            products(first: 10, query: "vendor:'\(brand.title)'") {
                edges {
                    node {
                        id
                        title
                        description
                        vendor
                        images(first: 1) {
                            edges {
                                node {
                                    url
                                }
                            }
                        }
                        variants(first: 1) {
                            edges {
                                node {
                                    id
                                    price
                                }
                            }
                        }
                    }
                }
            }
        }
        """

        api.callQueryApi(query: query, useToken: true) { (result: Result<GraphQLProductResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let products = response.data.products.edges.map { edge in
                    let node = edge.node
                    let imageUrl = node.images.edges.first?.node.url ?? ""
                    let priceString = node.variants.edges.first?.node.price ?? "0.0"
                    let price = Double(priceString) ?? 0.0

                    return BrandProduct(
                        id: node.id,
                        title: node.title,
                        description: node.description,
                        imageUrl: imageUrl,
                        price: price,
                        brandName: node.vendor
                    )
                }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
