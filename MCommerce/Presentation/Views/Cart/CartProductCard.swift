//
//  CartProductCard.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import SwiftUI

struct CartProductCard: View {
    let product: CartItem
    let onIncrease: () -> Void
    let onDecrease: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: product.imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)

                if let size = product.size, let color = product.color {
                    Text("Size: \(size), Color: \(color)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Text("\(product.price) \(product.currency)")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
            VStack(spacing: 8) {
                Button(action: onIncrease) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)

                Text("\(product.quantity ?? 1)")
                    .font(.headline)
                    .padding(.vertical, 4)

                Button(action: onDecrease) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(product.quantity ?? 1 > 1 ? .blue : .gray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}
