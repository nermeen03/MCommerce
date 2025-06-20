//
//  Order.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

struct OrderDataResponse: Identifiable {
    let id = UUID()
    var price: String
    var currencyCode: String
    var createdAt: String
    var productImage: String?
    
    var date: String {
        formatDate(createdAt)
    }
}

struct ValidationError: Identifiable {
    var id = UUID()
    var message: String
}

