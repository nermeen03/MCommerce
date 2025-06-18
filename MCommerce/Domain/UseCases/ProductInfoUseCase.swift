//
//  ProductInfoUseCase.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

struct ProductInfoUseCase {
    private let repository: ProductInfoRepositoryProtocol
    
    init(repository: ProductInfoRepositoryProtocol) {
        self.repository = repository
    }
    

    func getProductById(productId: String, completion: @escaping (Result<ProductDto, NetworkError>) -> Void) {
        repository.getProductById(productId: productId, completion: completion)
    }
}
