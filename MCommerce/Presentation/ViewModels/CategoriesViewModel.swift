//
//  CategoriesViewModel.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import SwiftUI
@MainActor
class CategoriesViewModel: ObservableObject {
    @Published var mainCategories: [CollectionDTO] = []
    @Published var allProducts: [BrandProduct] = []
    @Published var filteredProducts: [BrandProduct] = []

    @Published var productTypes: [String] = []
    @Published var selectedMainCategory: String = ""
    @Published var selectedProductType: String = ""

    private let productRepository: ProductRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol = DIContainer.shared.productRepository) {
        self.productRepository = productRepository
    }

    func loadMainCategories() {
        productRepository.fetchCollections { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let collections):
                DispatchQueue.main.async {
                    self.mainCategories = collections
                    if let men = collections.first(where: { $0.title.lowercased() == "men" }) {
                        self.didSelectMainCategory(men)
                    } else if let first = collections.first {
                        self.didSelectMainCategory(first)
                    }
                }

            case .failure(let error):
                print("Failed to fetch collections:", error)
            }
        }
    }

    func didSelectMainCategory(_ category: CollectionDTO) {
        selectedMainCategory = category.title
        selectedProductType = ""
        allProducts = []
        filteredProducts = []
        productTypes = []

        productRepository.fetchProducts(inCollectionHandle: category.handle) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let products):
                    self.allProducts = products
                    self.filteredProducts = products
                    self.productTypes = Array(Set(products.map { $0.productType })).sorted()
                case .failure(let error):
                    print("Failed to fetch products for \(category.title):", error)
                    self.allProducts = []
                    self.filteredProducts = []
                    self.productTypes = []
                }
            }
        }
    }

    func selectProductType(_ type: String) {
        selectedProductType = type
        filteredProducts = allProducts.filter { $0.productType == type }
    }

    func resetFilter() {
        selectedProductType = ""
        filteredProducts = allProducts
    }
}
