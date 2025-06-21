//
//  CartManager.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//

import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []

    func addItem(_ item: CartItem) {
        items.append(item)
    }

    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    func totalPrice() -> Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
}

// CartItem.swift
struct CartItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
}
