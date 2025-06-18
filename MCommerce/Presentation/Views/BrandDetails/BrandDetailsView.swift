//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import SwiftUI

struct BrandDetailsView: View {
    let brand: Brand
    @StateObject var viewModel: BrandDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(brand.title)
                    .font(.system(size: 40, weight: .bold))

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.products) { product in
                        BrandProductCard(product: product)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadProducts(for: brand)
        }
    }
}

struct BrandProductCard: View {
    let product: BrandProduct

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFit()
                case .failure(_):
                    Image(systemName: "photo")
                default:
                    ProgressView()
                }
            }
            .frame(height: 120)
            .cornerRadius(10)

            Text(product.title)
                .font(.headline)
            Text(product.description)
                .font(.caption)
                .foregroundColor(.gray)
            Text("$\(String(format: "%.2f", product.price))")
                .bold()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
