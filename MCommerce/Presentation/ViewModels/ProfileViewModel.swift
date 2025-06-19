//
//  ProfileViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

class OrderViewModel : ObservableObject{
    @Published var ordersArray : [OrderDataResponse] = []
    @Published var isLoading = true

    func getOrders(){
        ordersArray.removeAll()
        
        OrderRepo().getOrderTest { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):

                    self.ordersArray = response.data.orders.edges.map { item in
                        let data = item.node
                        let price = data.totalPriceSet.shopMoney.amount
                        let currencyCode = data.totalPriceSet.shopMoney.currencyCode
                        let createdAt = data.createdAt
                        let productImage = data.lineItems.edges.first?.node.variant?.product?.images.edges.first?.node.originalSrc
                        return OrderDataResponse(price: price, currencyCode: currencyCode, createdAt: createdAt, productImage: productImage)
                    }
                case .failure(let error):
                    print("Error fetching orders: \(error)")
                }
            }
        }
    }
}
