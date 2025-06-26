//
//  OrderRepo.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
import SafariServices
import SwiftUI

struct OrderRepo {
    func getOrderTest(completion: @escaping (Result<[OrderDataResponse], NetworkError>) -> Void) {
        var orders : [OrderDataResponse] = []

        FirebaseFirestoreHelper.shared.getAllOrderIds{ (result) in
            switch result{
            case .success(let value):
                value.forEach {id in
                    let query = """
                        query {
                        draftOrder(id: "\(id)"){
                            id
                            name
                            email
                            status
                            createdAt
                            tags
                            appliedDiscount {
                              title
                              description
                              value
                              valueType
                              amount
                            }

                            shippingAddress {
                              name
                              address1
                              address2
                              city
                              country
                              phone
                            }


                            lineItems(first: 50) {
                              edges {
                                node {
                                  id
                                  title
                                  quantity
                                  customAttributes {
                                    key
                                    value
                                  }
                                  appliedDiscount {
                                    title
                                    description
                                    value
                                    valueType
                                    amount
                                  }
                                  originalUnitPriceSet {
                                    shopMoney {
                                      amount
                                      currencyCode
                                    }
                                  }
                                  variant {
                                    id
                                    title
                                    sku
                                  }
                                }
                              }
                            }

                            subtotalPriceSet {
                              shopMoney {
                                amount
                                currencyCode
                              }
                            }

                            totalPriceSet {
                              shopMoney {
                                amount
                                currencyCode
                              }
                            }
                          }
                        }

                        """

                    ApiCalling().callQueryApi(query: query, useToken: true) { (result: Result<DraftOrderQueryResponse, NetworkError>) in
                        switch result{
                        case .success(let response):
                            if response.data.draftOrder.email == UserDefaultsManager.shared.getEmail(){
                                let order = response.data.draftOrder
                                orders.append(OrderDataResponse(price: order.totalPriceSet.shopMoney.amount, currencyCode: order.totalPriceSet.shopMoney.currencyCode, createdAt: order.createdAt, productImage: order.lineItems.edges.first?.node.customAttributes.first?.value))
                            }
                            completion(.success(orders))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(.invalidResponse))
            }
        }
    }

    func createOrder(
      customerId: String,
      cartItems: [CartItem],
      shippingAddress: ShippingAddress,
      paymentMethod : String,
      discount : Double,
      completion: @escaping (String) -> Void
    ) {
        let lineItemsInput = cartItems.map { item in
            var lineItem: [String: Any] = [
                "variantId": item.variantId!,
                "quantity": item.quantity!
            ]
            
            if let imageUrl = item.imageUrl {
                lineItem["customAttributes"] = [
                    ["key": "imageUrl", "value": imageUrl]
                ]
            }
            
            return lineItem
        }
        
        let customerId = UserDefaultsManager.shared.getUserId() ?? ""
        let customerEmail = UserDefaultsManager.shared.getEmail() ?? ""

        let query = """
            mutation draftOrderCreate($input: DraftOrderInput!) {
              draftOrderCreate(input: $input) {
                draftOrder {
                  id
                }
              }
            }
        """
        let variables: [String: Any] = [
            "input": [
                "customerId": "gid://shopify/Customer/\(customerId)",
                "email": customerEmail,
                "taxExempt": true,
                "tags": ["Paied via \(paymentMethod)"],
                "shippingAddress": [
                    "address1": shippingAddress.address1,
                    "address2": shippingAddress.address2,
                    "city": shippingAddress.city,
                    "country": shippingAddress.country,
                    "phone": shippingAddress.phone
                ],
                "appliedDiscount": [
                    "description": "damaged",
                    "value": discount,
                    "amount": discount,
                    "valueType": "FIXED_AMOUNT",
                    "title": "Custom"
                ],
                "lineItems": lineItemsInput,
            ]
        ]
        

        ApiCalling().callQueryApi(query: query, variables: variables, useToken: true) { (result: Result<DraftOrderCreateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                UserDefaultsManager.shared.clearCartId()
                UserDefaultsManager.shared.setCartBadgeCount(0)
                FirebaseFirestoreHelper.shared.addOrderId(orderId: response.data.draftOrderCreate.draftOrder.id, completion: {
                    result in
                    switch result {
                    case .success:
                        completion("Order is Completed")
                    case .failure(let error):
                        completion(error.localizedDescription)
                    }
                })
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }

}
