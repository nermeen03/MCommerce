//
//  DiscountRepository.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import Foundation

class DiscountRepository : DiscountRepositoryProtocol, ObservableObject {
    
    let remoteService : RemoteServicesProtocol
    
    init(remoteService: RemoteServicesProtocol) {
        self.remoteService = remoteService
    }
    
    func getDiscounts(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void){
        
        let query = """
          {
            discountNodes(first: 10) {
              edges {
                node {
                  id
                  discount {
                    ... on DiscountCodeBasic {
                      title
                      status
                      codes(first: 10) {
                        nodes {
                          code
                        }
                      }
                    }
                  }
                }
              }
            }
          }


        """
        
        remoteService.callQueryApi(query: query, variables: [:],useToken: true){
            (result: Result<DiscountNodesResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(Mapper.mapToDiscountData(from: response)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}




