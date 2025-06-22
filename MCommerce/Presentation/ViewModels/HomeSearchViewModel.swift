//
//  HomeSearchViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 21/06/2025.
//
import Foundation

class HomeSearchViewModel : ObservableObject{
    private let useCase : FetchAllProductsUseCase
    @Published var products : [Product] = []
 
    @Published var maxPrice: Double = 150
    @Published var minPrice: Double = 0
    @Published var searchText: String = "" {
        didSet {
          
            if let newMax = filteredProducts.map(\.price.currency).max() {
                       maxPrice = newMax
                       selectedMaxPrice = newMax
                       minPrice = filteredProducts.map(\.price.currency).min() ?? 0
                  }
        }
    }

    @Published var selectedMaxPrice: Double = 150
var filteredProducts: [Product] {
        var myProducts : [Product] = []
        if !searchText.isEmpty {
            myProducts = products
                .filter { product in
                    product.title
                        .lowercased()
                        .split(separator: " ")
                        .contains { word in word.starts(with: searchText.lowercased().trimmingCharacters(in: .whitespaces)) }
                }
                .filter { $0.price.currency <= selectedMaxPrice }
                .sorted { $0.price.currency > $1.price.currency }
        }
        return myProducts
        
    }

    init(useCase: FetchAllProductsUseCase) {
        self.useCase = useCase
        useCase.execute(num: 100){
            result in
            switch result{
            case .success(let products):
                self.products = products
                print("the search product ")
            case .failure(let error):
                print(error)
                print("ahhhhhhhh")
            }
        }
        
    }


}
