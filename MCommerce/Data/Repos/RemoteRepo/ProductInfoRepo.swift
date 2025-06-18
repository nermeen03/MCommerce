class ProductInfoRepo: ProductInfoRepositoryProtocol {
    func getProductById(productId: String, completion: @escaping (Result<ProductDto, NetworkError>) -> Void) {
        // Ensure product ID is a full Shopify GID
        let fullId: String
        if productId.hasPrefix("gid://shopify/Product/") {
            fullId = productId
        } else {
            fullId = "gid://shopify/Product/\(productId)"
        }

        let query = """
        {
          product(id: "\(fullId)") {
            id
            title
            description
            images(first: 10) {
              nodes {
                url
              }
            }
            variants(first: 10) {
              nodes {
                id
                title
                price {
                  amount
                }
                selectedOptions {
                  name
                  value
                }
              }
            }
          }
        }
        """

        ApiCalling().callQueryApi(
            query: query,
            variables: [:],
            completion: { (result: Result<GetProductResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    guard let product = response.data.product else {
                        completion(.failure(.invalidResponse))
                        return
                    }

                    let dto = ProductDto(
                        id: product.id,
                        title: product.title,
                        description: product.description,
                        images: product.images.nodes.map { $0.url },
                        variants: product.variants.nodes.map {
                            VariantDto(
                                id: $0.id,
                                title: $0.title,
                                price: $0.price.amount,
                                selectedOptions: $0.selectedOptions
                            )
                        }
                    )

                    completion(.success(dto))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
