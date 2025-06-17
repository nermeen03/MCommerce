//
//  DiscountRepository.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import Foundation

struct DiscountRepository : DiscountRepositoryProtocol {
    
    func getDiscounts() -> [Discount] {
        
        let query = """
          {
            discountNodes(query: "combines_with:product_discounts", first: 10) {
              edges {
                node {
                  id
                  discount {
                    ... on DiscountCodeBasic {
                      title
                      status
                      combinesWith {
                        productDiscounts
                      }
                    }
                    ... on DiscountCodeFreeShipping {
                      title
                      status
                      combinesWith {
                        productDiscounts
                      }
                    }
                  }
                }
              }
            }
          }
        """
        
        let apiCalling = ApiCalling()
        apiCalling.callRestApi(parameters: <#T##[String : Any]#>, json: <#T##String#>)
    }
}

