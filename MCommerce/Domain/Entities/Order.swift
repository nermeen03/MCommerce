//
//  Order.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//


//struct OrderDataResponse: Identifiable {
//    let id = UUID()
//    var price: String
//    var currencyCode: String
//    var createdAt: String
//    var productImage: String?
//    
//    var date: String {
//        formatDate(createdAt)
//    }
//}

struct ValidationError: Identifiable {
    var id = UUID()
    var message: String
}

//import Foundation
//
//struct OrderDataResponse: Identifiable, Hashable {
//    let id = UUID()
//    var productName: String
//    var price: String
//    var currencyCode: String
//    var createdAt: String
//    var productImage: String?
//    var progress: Double = 1.0
//
//    var date: String {
//        formatDate(createdAt)
//    }
//
//    static func == (lhs: OrderDataResponse, rhs: OrderDataResponse) -> Bool {
//        lhs.id == rhs.id &&
//        lhs.price == rhs.price &&
//        lhs.currencyCode == rhs.currencyCode &&
//        lhs.createdAt == rhs.createdAt &&
//        lhs.productImage == rhs.productImage
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(price)
//        hasher.combine(currencyCode)
//        hasher.combine(createdAt)
//        hasher.combine(productImage)
//    }
//}


import Foundation

struct OrderDataResponse: Identifiable, Hashable {
    let id: String
    let orderNumber: String
    let email: String
    let status: String
    let createdAt: String
    let appliedDiscount: DiscountTest?
    let shippingAddress: ShippingAddress?
    let subtotal: String
    let total: String
    let currencyCode: String
    let items: [OrderItem]
    var productImage: String?
    var progress: Double = 1.0

    var dateFormatted: String {
        formatDate(createdAt)
    }

    static func == (lhs: OrderDataResponse, rhs: OrderDataResponse) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct OrderItem: Identifiable, Hashable {
    let id: String
    let title: String
    let quantity: Int
    let price: String
    let currencyCode: String
    let imageURL: String?
}

extension OrderDataResponse {
    var dateeFormatted: String {
        formatDate(createdAt) 
    }
}
