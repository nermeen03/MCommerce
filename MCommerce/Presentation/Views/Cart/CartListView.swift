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
    
    @State var showAlert : Bool = false
    @State var indexToDelete : IndexSet?
    @State var showToast : Bool = false
    @State var message : String = ""
    
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
                                            }else{
                                                message = "You can not buy more than 5 items"
                                                showToast = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    self.showToast = false
                                                }
                                            }
                                        },
                                        onDecrease: {
                                            if cartViewModel.cartItems[index].quantity! > 1 {
                                                cartViewModel.cartItems[index].quantity! -= 1
                                                cartViewModel.removeOneProductFromCart(cartItem: item)
                                                cartVM.badgeCount -= 1
                                            }else{
                                                message = "You can not buy less than 1 item"
                                                showToast = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    self.showToast = false
                                                }
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
                            .onDelete(perform: { index in
                                showAlert = true
                                indexToDelete = index
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Are you sure?"), message: Text("You want to delete this item?"), primaryButton: .destructive(Text("Delete")) {
                                    deleteItems(at: indexToDelete!)
                                }, secondaryButton: .cancel())
                            }
                            
                        }.toast(isShowing: $showToast, message: message)
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
                                    .background(Color.deepPurple)
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
