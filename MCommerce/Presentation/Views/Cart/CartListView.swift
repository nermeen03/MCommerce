//
//  CartListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import SwiftUI

struct CartListView: View {
    
    @ObservedObject var cartViewModel: GetCartViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        VStack {
            if cartViewModel.isLoading {
                Spacer()
                ProgressView().font(.largeTitle)
                Spacer()
            } else {
                if cartViewModel.cartItems.isEmpty {
                    Spacer()
                    Image("noImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Text("Your Cart is Empty").font(.largeTitle)
                    Spacer()
                } else {
                    List {
                        ForEach(cartViewModel.cartItems) { item in
                            CartProductCard(
                                product: item,
                                onIncrease: {
                                    if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }) {
                                        if cartViewModel.cartItems[index].quantity! < 5 {
                                            cartViewModel.cartItems[index].quantity! += 1
                                            cartViewModel.addCartVM.addOrUpdateProduct(product: item, productVariant : item.variantId!)
                                        }
                                    }
                                },
                                onDecrease: {
                                    if let index = cartViewModel.cartItems.firstIndex(where: { $0.id == item.id }), cartViewModel.cartItems[index].quantity! > 1 {
                                        cartViewModel.cartItems[index].quantity! -= 1
                                        cartViewModel.removeProductFromCart(cartItem: item)
                                        
                                    }
                                }
                            )
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: deleteItems)
                        
                        Section {
                            Button(action: {
                                // Proceed to checkout action
                                var totalPrice = 0.0
                                cartViewModel.cartItems.forEach { item in
                                    totalPrice += Double(item.quantity ?? 0) * (Double(item.price) ?? 0.0)

                                }
                                coordinator.navigate(to: .checkout(price: totalPrice, items: cartViewModel.cartItems))
                            }) {
                                Text("Proceed to Checkout")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .listRowBackground(Color.clear)
                            .padding(.bottom, 80)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear {
            cartViewModel.cartItems.removeAll()
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
