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
//   @Published var availableColors = ["red", "blue", "black"]
//    @Published var availableSizes = ["36" , "35" ]
    @Published var product : ProductDto?
    @Published var variantPriceMap: [String: String] = [:]
    @Published var availableColors: [String] = []
    @Published var availableSizes: [String] = []
    @Published  var selectedColor: String? = nil
  @Published  var selectedSize: String? = nil
    
    
private let useCase = ProductInfoUseCase(repository: ProductInfoRepo())
    init(){
        useCase.getProductById(productId: "8596266680458") { [weak self] product in
            switch product {
                case .success(let product):
                DispatchQueue.main.async {
                                   self?.product = product
                                   self?.imageUrls = product.images
                                   self?.extractOptionsAndPrices(from: product.variants)
                    self?.selectedSize = self?.availableSizes[0]
                    self?.selectedColor = self?.availableColors[0]
                    
                               }
               
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
     
}
