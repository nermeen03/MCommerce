//
//  ProductAdView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct ProductAdView: View {
    @StateObject private var viewModel = ProductAdViewModel()
    var onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let product = viewModel.randomProduct {
                HStack{
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 28))
                            .padding()
                    }
                }
                AsyncImage(url: URL(string: product.images.edges.first?.node.url ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }.padding()
                
                HStack{
                    Text(product.title)
                        .font(.title).padding()
                    Text("\(product.priceRange.minVariantPrice.amount) \(product.priceRange.minVariantPrice.currencyCode)")
                        .bold()
                }
                
                Text(product.description)
                    .font(.headline)
                    .lineLimit(4)
                    .foregroundColor(.gray).padding()
                
                if let urlString = product.onlineStoreUrl, let url = URL(string: urlString) {
                    Link("View Product", destination: url)
                        .font(.callout)
                        .foregroundColor(.blue)
                }
                
                HStack{
                    Spacer()
                    Button("More Info", action: {
                
                    }).font(.headline).padding()
                }
                Spacer()
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchRandomProduct()
                    }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.95))
        .edgesIgnoringSafeArea(.all)
        .padding()
    }
}

