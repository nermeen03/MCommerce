//
//  BrandViewModel.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//

import Foundation

class BrandViewModel: ObservableObject {
    @Published var brands: [Brand] = []
    @Published var error: String?

    private let repository: BrandRepositoryProtocol

    init(repository: BrandRepositoryProtocol) {
        self.repository = repository
        if brands.isEmpty {
            fetchBrands()
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
