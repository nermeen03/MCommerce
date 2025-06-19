//
//  OrderRepo.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

struct OrderRepo {
    func getOrderTest(completion : @escaping (Result<OrdersResponse, NetworkError>) -> Void){
        let query = """
            {
              orders(first: 5) {
                edges {
                  node {
                    id
                    name
                    createdAt
                    totalPriceSet {
                      shopMoney {
                        amount
                        currencyCode
                      }
                    }
                    lineItems(first: 5) {
                      edges {
                        node {
                          title
                          quantity
                          variant {
                            id
                            image {
                              originalSrc
                            }
                            product {
                              images(first: 1) {
                                edges {
                                  node {
                                    originalSrc
                                    altText
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
              }
            }

            """
        ApiCalling().callQueryApi(query: query,useToken: true ,completion: {(result : Result<OrdersResponse, NetworkError>) in
            completion(result)
        })
    }
    
//    func getOrderTest(completion: @escaping (Result<OrdersResponse, NetworkError>) -> Void) {
//        let customerId = UserDefaultsManager.shared.getUserId() ?? "customerId"
//        let query = """
//        {
//          customer(id: "\(customerId)") {
//            id
//            firstName
//            lastName
//            email
//            orders(first: 5) {
//              edges {
//                node {
//                  id
//                  name
//                  createdAt
//                  totalPriceSet {
//                    shopMoney {
//                      amount
//                      currencyCode
//                    }
//                  }
//                  lineItems(first: 5) {
//                    edges {
//                      node {
//                        title
//                        quantity
//                        variant {
//                          id
//                          image {
//                            originalSrc
//                          }
//                          product {
//                            images(first: 1) {
//                              edges {
//                                node {
//                                  originalSrc
//                                  altText
//                                }
//                              }
//                            }
//                          }
//                        }
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
//        ApiCalling().callQueryApi(query: query, useToken: true) { (result: Result<OrdersResponse, NetworkError>) in
//            completion(result)
//        }
//    }

}
