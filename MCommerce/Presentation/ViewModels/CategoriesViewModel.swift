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
    @Published var subCategories: [SubCategory] = []
    @Published var products: [BrandProduct] = []

    @Published var selectedMainCategory: String = ""
    @Published var selectedSubCategory: String = ""

    private let productRepository: ProductRepositoryProtocol
    private let subCategoryRepository: SubCategoryRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol = DIContainer.shared.productRepository,
         subCategoryRepository: SubCategoryRepositoryProtocol = RemoteSubCategoryRepository()) {
        self.productRepository = productRepository
        self.subCategoryRepository = subCategoryRepository
    }

    func loadMainCategories() {
        productRepository.fetchCollections { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let collections):
                let main = collections.filter { !$0.title.contains("|") }
                DispatchQueue.main.async {
                    self.mainCategories = main
                    self.loadSubCategories()
                    if let menCategory = main.first(where: { $0.title == "Men" }) {
                        self.didSelectMainCategory(menCategory)
                    } else if let firstCategory = main.first {
                        self.didSelectMainCategory(firstCategory)
                    }
                }
            case .failure(let error):
                print("Failed to fetch collections: \(error)")
            }
        }
    }

    func loadSubCategories() {
        subCategoryRepository.fetchSubCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let subs):
                DispatchQueue.main.async {
                    self.subCategories = subs
                }
            case .failure(let error):
                print("Failed to load subcategories: \(error)")
            }
        }
    }

    func didSelectMainCategory(_ category: CollectionDTO) {
        selectedMainCategory = category.title
        let sub = subCategories.filter { $0.parentCategory == category.title }

        DispatchQueue.main.async {
            self.selectedSubCategory = ""
            if sub.isEmpty {
                self.productRepository.fetchProducts(inCollectionHandle: category.handle) { [weak self] result in
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
            } else {
                self.subCategories = sub
                if let first = sub.first {
                    self.didSelectSubCategory(first)
                }
            }
        }
    }

    func didSelectSubCategory(_ sub: SubCategory) {
        selectedSubCategory = sub.title
        productRepository.fetchProducts(inCollectionHandle: sub.handle) { [weak self] result in
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
