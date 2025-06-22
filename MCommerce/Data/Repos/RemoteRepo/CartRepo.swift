//
//  CartRepo.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import Foundation

struct CartRepo {
    
    func createCart(completion: @escaping (Result<String, NetworkError>) -> Void) {
        let mutation = """
        mutation {
          cartCreate {
            cart {
              id
              checkoutUrl
            }
          }
        }
        """
        
        ApiCalling().callQueryApi(query: mutation) { (result: Result<CartCreateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                if let cartId = response.data?.cartCreate?.cart?.id {
                    completion(.success(cartId))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addProductToCart(cartId: String, cartItem: CartItem, variantId: String, quantity: Int = 1, completion: @escaping (Result<String, NetworkError>) -> Void) {
        print("Adding to Cart: \(cartItem)")
        
        let query = """
            mutation {
              cartLinesAdd(cartId: "\(cartId)", lines: [{merchandiseId: "\(variantId)", quantity: \(quantity)}]) {
                cart {
                  id
                  totalQuantity
                  checkoutUrl
                  lines(first: 100) {
                    edges {
                      node {
                        id
                        quantity
                        merchandise {
                          ... on ProductVariant {
                            id
                            title
                            price {
                              amount
                              currencyCode
                            }
                            product {
                              title
                              featuredImage {
                                url
                              }
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
        
        ApiCalling().callQueryApi(query: query) { (result: Result<CartResponse, NetworkError>) in
            switch result {
            case .success(_):
                completion(.success("Added to Cart"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    func getCartItems(cartId: String, completion: @escaping (Result<[CartItem], NetworkError>) -> Void) {
        let query = """
        query {
          cart(id: "\(cartId)") {
            id
            totalQuantity
            checkoutUrl
            lines(first: 100) {
              edges {
                node {
                  id
                  quantity
                  merchandise {
                    ... on ProductVariant {
                      id
                      title
                      price {
                        amount
                        currencyCode
                      }
                      product {
                        title
                        featuredImage {
                          url
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

        ApiCalling().callQueryApi(query: query) { (result: Result<GetCartResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let items = response.data?.cart?.lines?.edges.map { edge -> CartItem in
                    let variantParts = edge.node.merchandise.title.components(separatedBy: " / ")
                    return CartItem(
                        id: edge.node.id,
                        variantId: edge.node.merchandise.id,
                        quantity: edge.node.quantity,
                        title: edge.node.merchandise.product.title,
                        price: edge.node.merchandise.price.amount,
                        currency: edge.node.merchandise.price.currencyCode ?? "USD",
                        imageUrl: edge.node.merchandise.product.featuredImage?.url,
                        color: variantParts.count > 1 ? variantParts.last : nil,
                        size: variantParts.first
                    )
                } ?? []
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCartLineId(for cartId: String, variantId: String, completion: @escaping (String?) -> Void) {
        let query = """
        query {
          cart(id: "\(cartId)") {
            lines(first: 100) {
              edges {
                node {
                  id
                  quantity
                  merchandise {
                    ... on ProductVariant {
                      id
                    }
                  }
                }
              }
            }
          }
        }
        """
        
        ApiCalling().callQueryApi(query: query) { (result: Result<GetCartResponseID, NetworkError>) in
            switch result {
            case .success(let response):
                let lineId = response.data?.cart?.lines?.edges.first(where: { $0.node.merchandise.id == variantId })?.node.id
                completion(lineId)
            case .failure:
                completion(nil)
            }
        }
    }

    
    func deleteCartLine(cartId: String, lineId: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let mutation = """
        mutation {
          cartLinesRemove(cartId: "\(cartId)", lineIds: ["\(lineId)"]) {
            cart {
              id
              totalQuantity
              checkoutUrl
              lines(first: 10) {
                edges {
                  node {
                    id
                    quantity
                    merchandise {
                      ... on ProductVariant {
                        id
                        title
                      }
                    }
                  }
                }
              }
            }
          }
        }
        """
        
        ApiCalling().callQueryApi(query: mutation) { (result: Result<CartResponse, NetworkError>) in
            switch result {
            case .success:
                completion(.success("✅ Product deleted from cart"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateCartLineQuantity(cartId: String, lineId: String, quantity: Int, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let mutation = """
        mutation {
          cartLinesUpdate(cartId: "\(cartId)", lines: [{ id: "\(lineId)", quantity: \(quantity) }]) {
            cart {
              id
              totalQuantity
              checkoutUrl
              lines(first: 100) {
                edges {
                  node {
                    id
                    quantity
                    merchandise {
                      ... on ProductVariant {
                        id
                        title
                        price {
                          amount
                          currencyCode
                        }
                        product {
                          title
                          featuredImage {
                            url
                          }
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

        ApiCalling().callQueryApi(query: mutation) { (result: Result<CartResponse, NetworkError>) in
            switch result {
            case .success(_):
                completion(.success("✅ Cart updated successfully"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}
