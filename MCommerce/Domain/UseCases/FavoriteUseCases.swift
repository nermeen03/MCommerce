//
//  FavoriteUseCases.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

class AddFavProdUseCase{
    let repo: ProductFavouriteRepositoryProtocol
    init(repo: ProductFavouriteRepositoryProtocol) {
        self.repo = repo
    }
    func execute(product: FavoriteProduct, completion: @escaping (Result<Void, Error>) -> Void){
        repo.addProductToFavorites(product: product, completion: completion)
    }

    
    
}


 class DeleteFavProdUseCase{
    let repo: ProductFavouriteRepositoryProtocol
    init(repo: ProductFavouriteRepositoryProtocol) {
        self.repo = repo
    }
    func execute( productId: String, completion: @escaping (Result<Void, Error>) -> Void){
        repo.deleteProductFromFavorites(productId: productId, completion: completion)
    }
}



class GetFavProdUseCase{
    let repo: ProductFavouriteRepositoryProtocol
    init(repo: ProductFavouriteRepositoryProtocol) {
        self.repo = repo
    }
    func execute( completion: @escaping (Result<[FavoriteProduct], Error>) -> Void){
        repo.getFavorites( completion: completion)
    }
}
 class CheckFavouriteProdUseCase{
    let repo: ProductFavouriteRepositoryProtocol
    init(repo: ProductFavouriteRepositoryProtocol) {
        self.repo = repo
    }
    func execute( productId: String, completion: @escaping (Bool) -> Void){
        repo.checkIfProductInFav(id: productId, completion: completion)
    }
}
