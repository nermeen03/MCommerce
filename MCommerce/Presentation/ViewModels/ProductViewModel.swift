//
//  ProductViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import Foundation

class ProductAdViewModel: ObservableObject {
    @Published var randomProduct: ProductDetail?
    
    private let remote = ApiCalling()

    func fetchRandomProduct() {
        let query = """
        {
          products(first: 20) {
            edges {
              node {
                id
                title
                description
                onlineStoreUrl
                priceRange {
                  minVariantPrice {
                    amount
                    currencyCode
                  }
                }
                images(first: 1) {
                  edges {
                    node {
                      url
                    }
                  }
                }
              }
            }
          }
        }
        """

        remote.callQueryApi(query: query) { (result: Result<ProductTest, NetworkError>) in
            switch result {
            case .success(let response):
                if let randomNode = response.data.products.edges.randomElement() {
                    DispatchQueue.main.async {
                        self.randomProduct = randomNode.node
                    }
                }
            case .failure(let error):
                print("Error fetching random product: \(error.localizedDescription)")
            }
        }
    }
}
