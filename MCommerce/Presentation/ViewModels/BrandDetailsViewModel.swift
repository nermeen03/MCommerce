//
//  BrandDetailsViewModel.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import Foundation

final class BrandDetailsViewModel: ObservableObject {
    @Published var products: [BrandProduct] = []
    private let repository: BrandDetailsRepositoryProtocol

    init(repository: BrandDetailsRepositoryProtocol) {
        self.repository = repository
    }

    func loadProducts(for brand: Brand) {
        repository.fetchProducts(for: brand) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    print("Failed to load brand products:", error)
                }
            }
        }
    }
}
