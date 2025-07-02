//
//  ProductInfoViewNodel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import Foundation
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var imageUrls: [String] = []
    @Published var isLoading: Bool = true
    @Published var product : ProductDto?
    @Published var variantPriceMap: [String: String] = [:]
    @Published var availableColors: [String] = []
    @Published var availableSizes: [String] = []
    @Published  var selectedColor: String? = nil
    @Published  var selectedSize: String? = nil
    @Published var price: String? = nil
    @Published var isFav: Bool = false
    @Published var isLoggedIn: Bool
    @Published var isAlertActive: Bool = false
    private let FetchInfoUseCase : ProductInfoUseCase
    private let addFavUseCase : AddFavProdUseCase
    private let deleteFavUseCase : DeleteFavProdUseCase
    private let checkProductsUseCase : CheckFavouriteProdUseCase
    private let cartViewModel : AddCartViewModel
    
    private let productId : String
    init(useCase : ProductInfoUseCase, id : String , deleteFavUseCase : DeleteFavProdUseCase , checkProductsUseCase : CheckFavouriteProdUseCase , AddFavUseCase : AddFavProdUseCase, cartUseCase : AddCartViewModel){
        self.FetchInfoUseCase = useCase
        self.productId = id
        self.deleteFavUseCase = deleteFavUseCase
        self.checkProductsUseCase = checkProductsUseCase
        self.addFavUseCase = AddFavUseCase
        self.cartViewModel = cartUseCase
        self.isLoggedIn = UserDefaultsManager.shared.isLoggedIn()
        print(isLoggedIn)
        FetchInfoUseCase.getProductById(productId: productId) { [weak self] product in
            switch product {
            case .success(let product):
                DispatchQueue.main.async {
                    self?.product = product
                    self?.imageUrls = product.images
                    self?.extractOptionsAndPrices(from: product.variants)
                    self?.selectedSize = self?.availableSizes[0]
                    self?.selectedColor = self?.availableColors[0]
                    
                    
                }
                
                
                    self?.checkFav()
                
                
                product.variants.forEach { variant in
                    print(variant .price)
                    print(variant .title)
                    print("selcted option")
                    for option in variant .selectedOptions {
                        print(option .name)
                        print(option .value)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        
    }
    func checkFav(){
        if(isLoggedIn){
            checkProductsUseCase.execute(productId: productId.filter{$0.isNumber}) { [weak self] exist in
                self?.isFav = exist
                self?.isLoading = false
            }}
        else{
            self.isLoading = false
        }
    }
    func addToFav(){
        if UserDefaultsManager.shared.isLoggedIn() {
            guard let product = product,
                  let imageUrl = product.images.first else {
                print("Invalid product data")
                return
            }
            
            let favProd = FavoriteProduct(
                productId: product.id.filter{$0.isNumber},
                title: product.title,
                imageUrl: imageUrl
            )
            
            addFavUseCase.execute(product: favProd) { [weak self] result in
                switch result {
                case .success:
                    print("")
                    
                case .failure(let error):
                    print("")
                    
                }
            }
        }
    }
    func deleteFromFav(){
        if UserDefaultsManager.shared.isLoggedIn() {
            deleteFavUseCase.execute(productId: self.productId.filter{$0.isNumber}) { [weak self] result in
                switch result {
                case .success:
                    print("")
                    
                case .failure(let error):
                    print("")
                    
                }
            }
        }
    }
    
    private func extractOptionsAndPrices(from variants: [VariantDto]) {
        var colors: Set<String> = []
        var sizes: Set<String> = []
        var priceMap: [String: String] = [:]
        
        for variant in variants {
            var color: String?
            var size: String?
            
            for option in variant.selectedOptions {
                if option.name.lowercased() == "color" {
                    color = option.value
                    colors.insert(option.value)
                } else if option.name.lowercased() == "size" {
                    size = option.value
                    sizes.insert(option.value)
                }
            }
            
            // Build key like "black|OS"
            if let c = color, let s = size {
                let key = "\(c)|\(s)"
                priceMap[key] = variant.price
            }
        }
        
        self.availableColors = Array(colors)
        self.availableSizes = Array(sizes)
        self.variantPriceMap = priceMap
    }
    
    func priceForSelected(color: String, size: String) -> String? {
        return variantPriceMap["\(color)|\(size)"]
    }
    func updatePriceForSelection() {
        guard let color = selectedColor, let size = selectedSize else {
            price = nil
            return
        }
        price = priceForSelected(color: color, size: size)
    }
    func colorFromName(_ name: String) -> Color {
        switch name.lowercased() {
        case "red": return .red
        case "blue": return .blue
        case "black": return .black
        case "green": return .green
        case "yellow": return .yellow
        case "orange": return .orange
        case "gray": return .gray
        default: return .clear // fallback for unknown names
        }
    }
    func addToCart() {
        guard let product = product else { return }
        
        guard let selectedColor = selectedColor, let selectedSize = selectedSize else {
            print("⚠️ Please select color and size first")
            return
        }
        guard let selectedVariant = product.variants.first(where: {
            $0.title.contains(selectedColor) && $0.title.contains(selectedSize)
        }) else {
            print("❗ No matching variant found for selection")
            return
        }
        let saveProduct = CartItem(id: product.id,productId: productId ,variantId: product.variants.first?.id ?? "", title: product.title, price: product.variants.first?.price ?? "\(0)", currency: "USD", imageUrl: imageUrls.first, color: selectedColor, size: selectedSize, checkoutUrl: "")
        
        self.cartViewModel.addOrUpdateProduct(product: saveProduct, productVariant: selectedVariant.id)
        
    }
    
    
}
