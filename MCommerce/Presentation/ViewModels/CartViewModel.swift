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
    
    func addOrUpdateProduct(product: ProductDto,productVariant: VariantDto, quantity: Int = 1) {
        addCartUseCase.addOrUpdateProduct(product: product, productVariant: productVariant ,completion: { result in
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
    let getCartUseCase : GetCartUseCase
    init(getCartUseCase: GetCartUseCase) {
        self.getCartUseCase = getCartUseCase
    }
    
    func getProducts(){
        isLoading = true
        getCartUseCase.getCart(completion: {[weak self]  result in
            self?.isLoading = false
            self?.cartItems = result
        })
    }
    func removeProductFromCart(cartItem: CartItem) {
        getCartUseCase.removeProductFromCart(cartItem: cartItem) { result in
            switch result {
            case .success(let message):
                print(message)
                // Refresh cart if needed:
                self.getProducts()
            case .failure(let error):
                print("❌ Failed to delete product: \(error)")
            }
        }
    }

}
