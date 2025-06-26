//
//  CartViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import Foundation

class AddCartViewModel : ObservableObject{
    
    @Published var result : String?
    var cartBadgeVM : CartBadgeViewModel
    let addCartUseCase : AddInCartUseCase
    
    init(addCartUseCase: AddInCartUseCase, cartBadgeVM : CartBadgeViewModel) {
        self.addCartUseCase = addCartUseCase
        self.cartBadgeVM = cartBadgeVM
    }
    
    func addOrUpdateProduct(product: CartItem,productVariant: String, quantity: Int = 1) {
        addCartUseCase.addOrUpdateProduct(product: product, productVariantId: productVariant,completion: { result in
            switch result {
            case .success(let message):
                self.cartBadgeVM.badgeCount += 1
                self.result = message
            case .failure(let error):
                self.result = error.localizedDescription
            }
        })
    }
}
class GetCartViewModel : ObservableObject{
    
    @Published var cartItems: [CartItem] = []
    @Published var isLoading: Bool = false
    let getCartUseCase : GetCartUseCase
    var cartBadgeVM : CartBadgeViewModel
    var addCartVM : AddCartViewModel
    
    init(getCartUseCase: GetCartUseCase, cartBadgeVM : CartBadgeViewModel, addCartVM : AddCartViewModel) {
        self.getCartUseCase = getCartUseCase
        self.cartBadgeVM = cartBadgeVM
        self.addCartVM = addCartVM
    }
    
    func getProducts(){
        if UserDefaultsManager.shared.getCartId() != nil{
            isLoading = true

            getCartUseCase.getCart(completion: {[weak self]  result in
                self?.isLoading = false
                self?.cartItems = result
            })
        }else{
            isLoading = false
        }
    }
    func removeProductFromCart(cartItem: CartItem) {
        var product = cartItem
        self.cartBadgeVM.badgeCount -= cartItem.quantity ?? 0
        if cartItem.quantity ?? 0 >= 1 {
            product.quantity! -= 1
            getCartUseCase.updateProductInCart(product: product, completion: {result in
                switch result {
                case .success(let message):
                    print(message)
                case .failure(let error):
                    print("❌ Failed to delete product: \(error)")
                }
            })
        }else{
            getCartUseCase.removeProductFromCart(cartItem: cartItem) { result in
                switch result {
                case .success(let message):
                    print(message)
                    if cartItem.quantity ?? 0 >= 1 {
                        self.addCartVM.addOrUpdateProduct(product: cartItem, productVariant: cartItem.variantId ?? "")
                    }
                    self.getProducts()
                case .failure(let error):
                    print("❌ Failed to delete product: \(error)")
                }
            }
        }
    }
}
