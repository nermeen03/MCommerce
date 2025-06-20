//
//  Protocol.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

protocol DiscountRepositoryProtocol {
    func getDiscounts(completion: @escaping (Result<[DiscountData], NetworkError>) -> Void)
}
protocol AuthenticationRepositoryProtocol {
    func register(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void)
    func login(email: String, password: String, completion: @escaping (Result<CustomerAccessToken, NetworkError>) -> Void)
    func getUserId(accessToken: String, completion: @escaping (Result<Customer, NetworkError>) -> Void) 
}
protocol ProductInfoRepositoryProtocol {
    func getProductById(productId: String, completion: @escaping (Result<ProductDto, NetworkError>) -> Void)
}
protocol ProductFavouriteRepositoryProtocol {
    func addProductToFavorites(product: FavoriteProduct, completion: @escaping (Result<Void, Error>) -> Void)

    func deleteProductFromFavorites( productId: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getFavorites(completion: @escaping (Result<[FavoriteProduct], Error>) -> Void)
    func checkIfProductInFav(id: String, completion: @escaping (Bool) -> Void)
}
