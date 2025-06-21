//
//  CartUseCase.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

struct AddInCartUseCase{
    
    let cartRepo : CartRepo
    
    func addOrUpdateProduct(product: ProductDto, productVariant: VariantDto, quantity: Int = 1, completion : @escaping (Result<String, NetworkError>) -> Void) {
        guard let existingCartId = UserDefaultsManager.shared.getCartId() else {
            cartRepo.createCart { result in
                switch result {
                case .success(let cartId):
                    UserDefaultsManager.shared.setCartId(cartId)
                    print("created cart at \(cartId)")
                    self.addOrUpdate(cartId: cartId, product: product, productVariant: productVariant ,completion :completion)
                case .failure(let error):
                    print("Failed to create cart:", error)
                }
            }
            return
        }
        print("❌ Inside add")
        self.addOrUpdate(cartId: existingCartId, product: product, productVariant: productVariant ,completion: completion)
        
    }
    
    private func addOrUpdate(cartId : String, product : ProductDto,productVariant: VariantDto ,quantity : Int = 1, completion : @escaping (Result<String, NetworkError>) -> Void){
    
        cartRepo.getCartLineId(for: cartId, variantId: productVariant.id) { lineId in
            print(" 🔎 + \(lineId)")
            if let lineId = lineId {
                cartRepo.updateCartLineQuantity(cartId: cartId, lineId: lineId, quantity: quantity) { result in
                    completion(result)
                }
            } else {
                cartRepo.addProductToCart(cartId: cartId, product: product, quantity: quantity) { result in
                    completion(result)
                }
            }
        }
    }
    
}



struct GetCartUseCase{
    let cartRepo : CartRepo

    func getCart(completion : @escaping ([CartItem]) -> Void){
        guard let cartId = UserDefaultsManager.shared.getCartId() else {return}
        cartRepo.getCartItems(cartId: cartId) {result in
            switch result {
            case .success(let items):
                completion(items)
            case .failure(let error):
                completion([])
                print("Error fetching cart: \(error)")
            }
        }
    }
    func removeProductFromCart(cartItem: CartItem, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let cartId = UserDefaultsManager.shared.getCartId() else { return }

        cartRepo.deleteCartLine(cartId: cartId, lineId: cartItem.id) { result in
            completion(result)
        }
    }
}
