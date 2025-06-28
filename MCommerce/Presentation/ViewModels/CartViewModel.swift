//
//  CartViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import Foundation

class AddCartViewModel : ObservableObject{
    
    @Published var result : String?
    let addCartUseCase : AddInCartUseCase
    
    init(addCartUseCase: AddInCartUseCase) {
        self.addCartUseCase = addCartUseCase
    }
    
    func addOrUpdateProduct(product: CartItem,productVariant: String, quantity: Int = 1) {
        addCartUseCase.addOrUpdateProduct(product: product, productVariantId: productVariant,completion: { result in
            switch result {
            case .success(let message):
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
    @Published var isLoggedIn : Bool
    let getCartUseCase : GetCartUseCase
    var addCartVM : AddCartViewModel
    
    init(getCartUseCase: GetCartUseCase,addCartVM : AddCartViewModel) {
        self.getCartUseCase = getCartUseCase
        self.isLoggedIn = UserDefaultsManager.shared.isLoggedIn()
        self.addCartVM = addCartVM
    }
    
    func getProducts(){
        if UserDefaultsManager.shared.getCartId() != nil{
            isLoading = true

            getCartUseCase.getCart(completion: {[weak self]  result in
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.cartItems = response
                case .failure:
                    self?.cartItems = []
                }
            })
        }else{
            isLoading = false
        }
    }
    func removeOneProductFromCart(cartItem: CartItem) {
        var product = cartItem
        if cartItem.quantity ?? 0 >= 1 {
            product.quantity! -= 1
            getCartUseCase.updateProductInCart(product: product, completion: {result in
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
            })
        }
    }
    func removeProductFromCart(cartItem: CartItem) {
        getCartUseCase.removeProductFromCart(cartItem: cartItem) { result in
            switch result {
            case .success(let message):
                print(message)
                self.getProducts()
            case .failure(let error):
                print("❌ Failed to delete product: \(error)")
            }
        }
    }
}
