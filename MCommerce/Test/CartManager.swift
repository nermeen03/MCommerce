//
//  CartManager.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//

import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [CartItemManager] = []

    func addItem(_ item: CartItemManager) {
        items.append(item)
    }

    func removeItem(_ item: CartItemManager) {
        items.removeAll { $0.id == item.id }
    }

    func totalPrice() -> Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
}

struct CartItemManager: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
}
