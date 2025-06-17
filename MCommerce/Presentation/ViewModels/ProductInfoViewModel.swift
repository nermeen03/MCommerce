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
   @Published var availableColors = ["red", "blue", "black"]
    @Published var availableSizes = ["36" , "35" ]

    
    func fetchProductImages() {
        // Simulating a network call
  
            self.imageUrls = [
                "https://images.unsplash.com/photo-1585386959984-a4155224c3b1", // Sneakers
                    "https://images.unsplash.com/photo-1606813902283-0278d7a32ae3", // Headphones
                    "https://images.unsplash.com/photo-1600185365462-8c684c4a6b6b" 
            ]
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
