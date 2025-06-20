//
//  ProductImagesSliderView.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import SwiftUI

struct ProductImagesSliderView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            let images = viewModel.product?.images ?? []
            
            TabView(selection: $currentIndex) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(16)
                                .padding(.horizontal, 8)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 240)
                                .clipped()
                                .cornerRadius(16)
                                .padding(.horizontal, 8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 80)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .tag(index)
                }
            }
            .frame(height: 240)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Indicator Dots
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.orange : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }.padding()
        }
    }
}

