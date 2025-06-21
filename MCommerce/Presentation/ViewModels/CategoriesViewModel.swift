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
    @Published var productTypes: [String] = []
    @Published var selectedMainCategory: String = ""
    @Published var selectedProductType: String = ""
    @Published var searchText: String = ""

    private let productRepository: ProductRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol = DIContainer.shared.productRepository) {
        self.productRepository = productRepository
    }

    var displayedProducts: [BrandProduct] {
        var products = allProducts

        if !selectedProductType.isEmpty {
            products = products.filter { $0.productType == selectedProductType }
        }

        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            let lowerSearch = searchText.lowercased().trimmingCharacters(in: .whitespaces)
            products = products.filter { product in
                let title = product.title
                let cleanedTitle: String
                if let range = title.range(of: "|") {
                    cleanedTitle = String(title[range.upperBound...]).trimmingCharacters(in: .whitespaces)
                } else {
                    cleanedTitle = title
                }

                return cleanedTitle
                    .lowercased()
                    .split(separator: " ")
                    .contains { word in
                        word.starts(with: lowerSearch)
                    }
            }
        }

        return products
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
        productTypes = []

        productRepository.fetchProducts(inCollectionHandle: category.handle) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let products):
                    self.allProducts = products
                    self.productTypes = Array(Set(products.map { $0.productType })).sorted()
                case .failure(let error):
                    print("Failed to fetch products for \(category.title):", error)
                    self.allProducts = []
                    self.productTypes = []
                }
            }
        }
    }

    func selectProductType(_ type: String) {
        selectedProductType = type
    }

    func resetFilter() {
        selectedProductType = ""
        searchText = ""
    }
}
