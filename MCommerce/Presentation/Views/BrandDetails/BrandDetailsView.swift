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
    @EnvironmentObject var coordinator: BrandsCoordinator 
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(brand.title)
                    .font(.system(size: 40, weight: .bold))

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.products) { product in
                        BrandProductCard(product: product) .onTapGesture {
                            coordinator.navigateToProductInfo(withId: product.id)
                        }
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

