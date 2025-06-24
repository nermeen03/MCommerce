//
//  Cart.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import Foundation

struct CartItem : Identifiable, Equatable {
    
    let id: String
    let variantId: String?
    var quantity: Int?
    let title: String
    let price: String
    let currency: String
    let imageUrl: String?
    let color: String?
    let size: String?
    let checkoutUrl: String

}
