//
//  BrandViewModel.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var brands: [Brand] = []
    @Published var error: String?
    @Published var suggestedProducts: [Product] = []
    private let suggestedProductUseCase : FetchAllProductsUseCase
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol , suggestedProductUseCase : FetchAllProductsUseCase) {
        self.repository = repository
        self.suggestedProductUseCase = suggestedProductUseCase
        if brands.isEmpty {
            fetchBrands()
        }
        if suggestedProducts.isEmpty {
            suggestedProductUseCase.execute(num: 50) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let products):
                        let randomFive = Array(products.shuffled().prefix(5))
                        self?.suggestedProducts = randomFive
                    case .failure(let error):
                        self?.error = error.localizedDescription
                    }
                }
            }

        }
        
    }

    func fetchBrands() {
        repository.fetchBrands { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let brands):
                    self?.brands = brands
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
