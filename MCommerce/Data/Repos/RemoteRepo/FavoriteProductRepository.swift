//
//  FavoriteProductRepository.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

class ProductFavouriteRepository : ProductFavouriteRepositoryProtocol {
    func checkIfProductInFav(id: String, completion: @escaping (Bool) -> Void) {
        FirebaseFirestoreHelper.shared.isProductFavorited(productId: id, completion: completion)
    }
    
    func addProductToFavorites(product: FavoriteProduct, completion: @escaping (Result<Void, Error>) -> Void){
        FirebaseFirestoreHelper.shared.addProductToFavorites(product: product) { result in
            completion(result)
        }
    }
    func deleteProductFromFavorites( productId: String, completion: @escaping (Result<Void, Error>) -> Void){
        FirebaseFirestoreHelper.shared.deleteProductFromFavorites(productId: productId, completion: completion)
    }
    func getFavorites( completion: @escaping (Result<[FavoriteProduct], Error>) -> Void){
        
        FirebaseFirestoreHelper.shared.getFavorites { result in
            completion(result)
        }
    }
}
