//
//  BrandRepository.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//
class BrandRepository: BrandRepositoryProtocol {
    private let service: RemoteServicesProtocol

    init(service: RemoteServicesProtocol) {
        self.service = service
    }

    func fetchBrands(completion: @escaping (Result<[Brand], NetworkError>) -> Void) {
        let query = """
        {
          collections(first: 16) {
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
}
