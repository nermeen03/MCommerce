//
//  CartListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import SwiftUI

struct CartListView: View {
    
    @ObservedObject var cartViewModel: GetCartViewModel
    
    var body: some View {
        List {
            ForEach(cartViewModel.cartItems) { item in
                CartProductCard(
                    product: item,
                    onIncrease: {
                        if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }) {
                            cartViewModel.cartItems[index].quantity += 1
                        }
                    },
                    onDecrease: {
                        if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }), cartViewModel.cartItems[index].quantity > 1 {
                            cartViewModel.cartItems[index].quantity -= 1
                        }
                    }
                )
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .onAppear {
            cartViewModel.getProducts()
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = cartViewModel.cartItems[index]
            cartViewModel.removeProductFromCart(cartItem: item)
        }
    }
}
