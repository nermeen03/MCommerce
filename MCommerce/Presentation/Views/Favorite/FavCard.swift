//
//  FavCard.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

import SwiftUI

struct FavCard: View {
    let product: FavoriteProduct
    private var filteredTitle: String {
        if let range = product.title.range(of: "|") {
            let trimmed = product.title[range.upperBound...]
            return trimmed.trimmingCharacters(in: .whitespaces)
        }
        return product.title
    }
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: product.imageUrl)){
                phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable().scaledToFill()
                            .frame(width: 130, height: 130).cornerRadius(8).padding(4)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable().scaledToFill()
                            .frame(width: 130, height: 130).cornerRadius(8).padding(4)
                    @unknown default:
                        EmptyView()
                    }
                }
            
            Text(filteredTitle).font(.subheadline).fontWeight(.medium)
            Spacer()
        }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
  
}

//#Preview {
//    FavCard()
//}
