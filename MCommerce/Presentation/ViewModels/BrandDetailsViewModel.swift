//
//  BrandDetailsViewModel.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import Foundation
final class BrandDetailsViewModel: ObservableObject {
    
    @Published var products: [BrandProduct] = [] {
        didSet {
         
         
            maxPrice = self.products.compactMap { Double($0.price.currency) }.max() ?? 0.0
            minPrice = self.products.compactMap { Double($0.price.currency) }.min() ?? 0.0
            selectedMaxPrice = self.maxPrice
            filterProducts()
           
        }
    }
  @Published  var minPrice: Double = 0
   @Published var maxPrice: Double = 300
    @Published var selectedMaxPrice: Double = 0.0 {
        didSet {
          
            filterProducts()
        }
    }

    @Published var filteredProducts: [BrandProduct] = []

    @Published var searchText: String = "" {
        didSet {
            filterProducts()
        }
    }

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

    func filterProducts() {
        guard !searchText.isEmpty else {
            filteredProducts = products.filter {
                Double($0.price.currency) <= selectedMaxPrice
            } .sorted { $0.price.currency > $1.price.currency }
            return
        }

        filteredProducts = products.filter { product in
            let title = product.title
            let cleanedTitle: String
            if let range = title.range(of: "|") {
                let trimmed = title[range.upperBound...]
                cleanedTitle = trimmed.trimmingCharacters(in: .whitespaces)
            } else {
                cleanedTitle = title
            }
            return cleanedTitle
                .lowercased()
                .split(separator: " ")
                .contains { word in
                    word.starts(with: searchText.lowercased().trimmingCharacters(in: .whitespaces))
                }
        }.filter {
            Double($0.price.currency) <= selectedMaxPrice
        }  .sorted { $0.price.currency > $1.price.currency }
    }

}

