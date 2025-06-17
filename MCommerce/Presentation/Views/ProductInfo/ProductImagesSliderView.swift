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
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.imageUrls.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: viewModel.imageUrls[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(12)
                                    .padding(.horizontal, 16)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 80)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(height: 240)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    viewModel.fetchProductImages()
                }

                // Indicator Dots
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.imageUrls.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.orange : Color.gray.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
}

#Preview {
    ProductImagesSliderView(viewModel: ProductViewModel())
}
