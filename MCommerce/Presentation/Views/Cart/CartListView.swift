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
    @EnvironmentObject var cartVM: CartBadgeVM
    
    var body: some View {
        VStack {
            if !cartViewModel.isLoggedIn {
                VStack{
                    
                    Text("You must login to see your cart").font(.title2).bold().bold().foregroundColor(.gray)
                }.frame(maxWidth: .infinity, maxHeight: .infinity ).background(.white.opacity(0.7))
            }
            else{
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
                            ForEach(cartViewModel.cartItems.indices) { index in
                                let item = cartViewModel.cartItems[index]
                                CartProductCard(
                                        product: item,
                                        quantity: $cartViewModel.cartItems[index].quantity,
                                        onIncrease: {
                                            if cartViewModel.cartItems[index].quantity! < 5 {
                                                cartViewModel.cartItems[index].quantity! += 1
                                                cartViewModel.addCartVM.addOrUpdateProduct(product: item, productVariant: item.variantId!)
                                                cartVM.badgeCount += 1
                                            }
                                        },
                                        onDecrease: {
                                            if cartViewModel.cartItems[index].quantity! > 1 {
                                                cartViewModel.cartItems[index].quantity! -= 1
                                                cartViewModel.removeOneProductFromCart(cartItem: item)
                                                cartVM.badgeCount -= 1
                                            }
                                        }
                                    )
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    print(item)
                                    coordinator.navigate(to: .productInfo(product: item.productId))
                                }
                            }
                            .onDelete(perform: deleteItems)
                            
                        }
                        Section {
                            Button(action: {
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
                            }.padding(.bottom, 80)
                        }
                        .listStyle(.plain)
                    }
                }
            }
        }.onAppear {
            cartViewModel.cartItems.removeAll()
            cartViewModel.getProducts()
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = cartViewModel.cartItems[index]
            cartViewModel.removeProductFromCart(cartItem: item)
            cartVM.badgeCount -= item.quantity ?? 1
        }
    }
}
