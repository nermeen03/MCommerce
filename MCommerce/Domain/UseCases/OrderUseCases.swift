//
//  OrderUseCases.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import Foundation
class getOrderUseCase{
    let orderRepo : OrderRepo
    init(orderRepo: OrderRepo) {
        self.orderRepo = orderRepo
    }
    
    func getOrders(completion: @escaping (Result<[OrderDataResponse], NetworkError>) -> Void){
        orderRepo.getOrderTest(completion: {result in
            completion(result)
        })
    }
}
