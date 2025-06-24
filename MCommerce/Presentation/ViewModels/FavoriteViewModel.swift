//
//  FavoriteViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

import Foundation
class FavoriteViewModel : ObservableObject {
    var favorites: [FavoriteProduct] = []{
        didSet {filterProducts()
            isLoading = false
        }
    }
    @Published var isLoading: Bool = true
    @Published var isAlertShowing: Bool = false
    @Published var isLoggedIn: Bool
    @Published var searchText: String = ""{
        didSet{
            filterProducts()
        }
    }
    @Published var filteredFavorites: [FavoriteProduct] = []
    private var getProductsUseCase : GetFavProdUseCase
    private var deleteProductUseCase : DeleteFavProdUseCase
    
    
    init(getProductsUseCase: GetFavProdUseCase , deleteProductUseCase: DeleteFavProdUseCase ) {
        self.getProductsUseCase = getProductsUseCase
        self.deleteProductUseCase = deleteProductUseCase
        self.isLoggedIn = UserDefaultsManager.shared.isLoggedIn()
        print(self.isLoggedIn)
        if(isLoggedIn){
            self.getProductsUseCase.execute { [weak self] result in
            switch result {
            case .success(let favorites):
                self?.favorites = favorites
            case .failure:
                break
            }
        }}
    }
    
    func deleteProduct(id: String){
        deleteProductUseCase.execute(productId: id) { [weak self] result in
            switch result {
            case .success:
            self!.favorites.removeAll { $0.productId == id }
            self?.filteredFavorites.removeAll{$0.productId == id}
                 
            case .failure:
                return
                }
            }
        
    }
    func filterProducts() {
      
        guard !searchText.isEmpty else {
            filteredFavorites = favorites
            return
        }

        filteredFavorites = favorites.filter { product in
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
        }
        }
    @Published var refreshToken = UUID()

    func refresh() {
        refreshToken = UUID() // This will trigger re-initiation of the view
    }

    
}
