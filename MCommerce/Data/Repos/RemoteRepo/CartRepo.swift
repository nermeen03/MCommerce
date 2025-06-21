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
    
    func addProductToCart(cartId: String, product: ProductDto, quantity: Int = 1, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let variant = product.variants.first else {
            print("❗ No variant found for product.")
            return
        }

        let query = """
        mutation {
          cartLinesAdd(cartId: "\(cartId)", lines: [{merchandiseId: "\(variant.id)", quantity: \(quantity)}]) {
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
        print("🔎 START getCartLineId → cartId: \(cartId), variantId: \(variantId)")
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
                print("✅✅✅ Expected Variant ID: \(variantId)")
                print("Cart Items Variant IDs: \(response.data?.cart?.lines?.edges.map { $0.node.merchandise.id } ?? [])")

                let lineId = response.data?.cart?.lines?.edges.first(where: { $0.node.merchandise.id == variantId })?.node.id
                completion(lineId)
            case .failure:
                completion(nil)
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
              lines(first: 10) {
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
                completion(.success("Updated Product Quantity in Cart"))
            case .failure(let error):
                completion(.failure(error))
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

    
}


//    func isProductInCart(cartId: String, productVariantId: String, completion: @escaping (Bool, String?) -> Void) {
//
//        let query = """
//        query {
//          cart(id: "\(cartId)") {
//            lines(first: 100) {
//              edges {
//                node {
//                  id
//                  merchandise {
//                    ... on ProductVariant {
//                      id
//                    }
//                  }
//                }
//              }
//            }
//          }
//        }
//        """
//
//        ApiCalling().callQueryApi(query: query) { (result: Result<CartResponse, NetworkError>) in
//            switch result {
//            case .success(let response):
//                if let lines = response.data?.cartLinesAdd?.cart?.lines?.edges {
//                    for edge in lines {
//                        if edge.node.merchandise.id == productVariantId {
//                            completion(true, edge.node.id)
//                            return
//                        }
//                    }
//                }
//                completion(false, nil)
//            case .failure:
//                completion(false, nil)
//            }
//        }
//    }

//    func updateProductQuantity(cartId: String, lineId: String, newQuantity: Int, completion: @escaping (Result<CartResponse, NetworkError>) -> Void) {
//        let mutation = """
//        mutation {
//          cartLinesUpdate(cartId: "\(cartId)", lines: [{ id: "\(lineId)", quantity: \(newQuantity) }]) {
//            cart {
//              id
//              totalQuantity
//              lines(first: 10) {
//                edges {
//                  node {
//                    id
//                    quantity
//                    merchandise {
//                      ... on ProductVariant {
//                        id
//                      }
//                    }
//                  }
//                }
//              }
//            }
//          }
//        }
//        """
//
//        ApiCalling().callQueryApi(query: mutation, completion: completion)
//    }
