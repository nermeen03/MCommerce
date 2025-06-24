//
//  CartUseCase.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

struct AddInCartUseCase{
    
    let cartRepo : CartRepo
    
    func addOrUpdateProduct(product: CartItem, productVariantId: String, completion : @escaping (Result<String, NetworkError>) -> Void) {
        guard let existingCartId = UserDefaultsManager.shared.getCartId() else {
            cartRepo.createCart { result in
                switch result {
                case .success(let cartId):
                    UserDefaultsManager.shared.setCartId(cartId)
                    print("created cart at \(cartId)")
                    self.addOrUpdate(cartId: cartId, product: product, productVariantId: productVariantId ,completion :completion)
                case .failure(let error):
                    print("Failed to create cart:", error)
                }
            }
            return
        }
        self.addOrUpdate(cartId: existingCartId, product: product, productVariantId: productVariantId ,completion: completion)
        
    }
    
    private func addOrUpdate(cartId : String, product : CartItem ,productVariantId: String , completion : @escaping (Result<String, NetworkError>) -> Void){
    
        cartRepo.getCartLineId(for: cartId, variantId: productVariantId) { lineId in
                cartRepo.addProductToCart(cartId: cartId, cartItem: product, variantId: productVariantId) { result in
                    completion(result)
                }
        }
    }
    
}



struct GetCartUseCase{
    let cartRepo : CartRepo
    
    func getCart(completion: @escaping (Result<[CartItem], NetworkError>) -> Void) {
        guard let cartId = UserDefaultsManager.shared.getCartId() else {
            completion(.failure(.invalidResponse))
            return
        }

        cartRepo.getCartItems(cartId: cartId) { result in
            completion(result) 
        }
    }

    func removeProductFromCart(cartItem: CartItem, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let cartId = UserDefaultsManager.shared.getCartId() else { return }
        
        cartRepo.deleteCartLine(cartId: cartId, lineId: cartItem.id) { result in
            completion(result)
        }
    }
    func updateProductInCart(product : CartItem, completion: @escaping (Result<String, NetworkError>) -> Void){
        guard let cartId = UserDefaultsManager.shared.getCartId() else { return }
        cartRepo.getCartLineId(for: cartId, variantId: product.variantId!) { lineId in
            if let lineId = lineId {
                cartRepo.updateCartLineQuantity(cartId: cartId, lineId: lineId, quantity: product.quantity ?? 0) { result in
                    switch result {
                    case .success(let message):
                        print(message)
                    case .failure(let error):
                        print("❌ Failed to update: \(error)")
                    }
                }
            } else {
                cartRepo.addProductToCart(cartId: cartId, cartItem: product, variantId: product.variantId!, quantity: product.quantity ?? 0) { result in
                    print(result)
                }
            }
        }
        
    }
    private func getLine(cartId : String, product : CartItem ,productVariantId: String , completion : @escaping (Result<String, NetworkError>) -> Void){
    
        cartRepo.getCartLineId(for: cartId, variantId: productVariantId) { lineId in
                cartRepo.addProductToCart(cartId: cartId, cartItem: product, variantId: productVariantId) { result in
                    completion(result)
                }
        }
    }
}
