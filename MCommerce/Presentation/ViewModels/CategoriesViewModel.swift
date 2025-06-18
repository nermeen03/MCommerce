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
    @Published var subCategories: [CollectionDTO] = []
    @Published var products: [BrandProduct] = []

    @Published var selectedMainCategory: String = ""
    @Published var selectedSubCategory: String = ""

    private let productRepository: ProductRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol = DIContainer.shared.productRepository) {
        self.productRepository = productRepository
    }

    func loadMainCategories() {
        productRepository.fetchCollections { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let collections):
                let main = collections.filter { !$0.title.contains("|") }
                DispatchQueue.main.async {
                    self.mainCategories = main
                }
            case .failure(let error):
                print(" Failed to fetch collections: \(error)")
            }
        }
    }

    func didSelectMainCategory(_ category: CollectionDTO) {
        selectedMainCategory = category.title
        subCategories = mainCategories.filter { $0.title.hasPrefix("\(category.title) |") }
        productRepository.fetchProducts(inCollectionHandle: category.handle) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                }
            case .failure(let error):
                print("❌ Failed to fetch products: \(error)")
            }
        }
    }

    func didSelectSubCategory(_ sub: CollectionDTO) {
        selectedSubCategory = sub.title

        productRepository.fetchProducts(inCollectionHandle: sub.title) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                }
            case .failure(let error):
                print("Failed to fetch products: \(error)")
            }
        }
    }
}
