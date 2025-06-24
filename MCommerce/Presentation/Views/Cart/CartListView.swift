//
//  CartListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import SwiftUI

struct CartListView: View {
    @State private var showSafari = false
       @State private var safariURL: URL? = nil
    @ObservedObject var cartViewModel: GetCartViewModel
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
                                cartViewModel.getProducts { checkoutUrl in
                                    if let urlString = checkoutUrl, let url = URL(string: urlString) {
                                        safariURL = url
                                        showSafari = true
                                    } else {
                                        print("❌ Invalid or missing checkout URL")
                                    }
                                }
                            }) {
                                Text("Proceed to Checkout")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .sheet(isPresented: $showSafari) {
                                if let url = safariURL {
                                    SafariView(url: url)
                                }
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
            if cartViewModel.cartItems.isEmpty {
                cartViewModel.getProducts { checkoutUrl in
                   
                }
            }

        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = cartViewModel.cartItems[index]
            cartViewModel.removeProductFromCart(cartItem: item)
        }
    }
}
