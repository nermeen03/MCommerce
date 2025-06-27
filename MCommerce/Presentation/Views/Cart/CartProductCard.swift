//
//  CartProductCard.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

import SwiftUI

struct CartProductCard: View {
    let product: CartItem
    @Binding var quantity: Int?
    let onIncrease: () -> Void
    let onDecrease: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: product.imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 70, height: 70)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(8)
                        .clipped()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(2)

                if let color = product.color , let size = product.size {
                    Text("Color: \(color) & " + "Size: \(size)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                HStack(spacing: 14) {
                    HStack(spacing: 12) {
                        
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                            .frame(width: 28, height: 28)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .onTapGesture(perform: onDecrease)


                        Text("\(quantity ?? 1)")
                            .font(.body)
                            .frame(width: 20)

                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .frame(width: 28, height: 28)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .onTapGesture(perform: onIncrease)

                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(.systemGray5))
                    .clipShape(Capsule())
                    .contentShape(Rectangle())


                    Text("$".symbol + "\(String(format: "%.2f", (Double(product.price.currency) ?? 0.0) * Double(quantity ?? 1)))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        .border(.blue, width: 1)
    }

}
