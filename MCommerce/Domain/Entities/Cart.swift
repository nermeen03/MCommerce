//
//  Cart.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

struct CartItem : Identifiable {
    let id: String
    var quantity: Int
    let title: String
    let price: String
    let currency: String
    let imageUrl: String?
    let color: String?
    let size: String?
}
