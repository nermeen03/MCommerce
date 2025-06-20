//
//  BrandProductCard.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import SwiftUI

struct BrandProductCard: View {
    let product: BrandProduct

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: product.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray.opacity(0.5))
                default:
                    Color.gray.opacity(0.2)
                }
            }
            .frame(height: 120)
            .cornerRadius(12)

            Text(product.brandName)
                .font(.caption)
                .foregroundColor(.gray)

            Text(filteredTitle)
                .font(.headline)
                .lineLimit(2)

            HStack {
                Text("$".symbol + "\(String(format: "%.2f", product.price.currency))")
                    .font(.subheadline)
                Spacer()
                Button {
                    // Handle cart
                } label: {
                    Image(systemName: "cart")
                }
            }
        }
        .padding()
        .frame(width: 160, height: 300)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    private var filteredTitle: String {
        if let range = product.title.range(of: "|") {
            let trimmed = product.title[range.upperBound...]
            return trimmed.trimmingCharacters(in: .whitespaces)
        }
        return product.title
    }
}

//#Preview {
//    BrandProductCard(product: <#BrandProduct#>)
//}
