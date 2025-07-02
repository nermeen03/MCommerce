//
//  BrandProductCard.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import SwiftUI

struct BrandProductCard: View {
    let product: BrandProduct
    var compact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: compact ? 6 : 10) {
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
            .frame(height: compact ? 80 : 120)
            .cornerRadius(compact ? 8 : 12)

            Text(product.brandName)
                .font(compact ? .caption2 : .caption)
                .foregroundColor(.gray)

            Text(filteredTitle)
                .font(compact ? .caption : .headline)
                .lineLimit(2)
            HStack {
                Text(CurrencyFormatter.format(amountInEGP: product.price))
                    .font(.subheadline)
                Spacer()
            }

//            HStack {
//                Text("$".currency + "\(String(format: "%.2f", product.price.currency))")
//                    .font(.subheadline)
//                Spacer()
//            }
        }
        .padding(compact ? 6 : 12)
        .frame(width: compact ? 120 : 160, height: compact ? 180 : 300)
        .background(Color.white)
        .cornerRadius(compact ? 10 : 16)
        .shadow(color: .gray.opacity(0.1), radius: compact ? 3 : 5, x: 0, y: 2)
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
