//
//  CategoriesView.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel = CategoriesViewModel()

    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.mainCategories) { category in
                        Text(category.title)
                            .foregroundColor(viewModel.selectedMainCategory == category.title ? .blue : .primary)
                            .bold(viewModel.selectedMainCategory == category.title)
                            .padding(.vertical, 4)
                            .onTapGesture {
                                viewModel.didSelectMainCategory(category)
                            }
                    }
                    Spacer()
                }
                .frame(width: 65)
                .padding()
                .background(Color.gray.opacity(0.1))
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.subCategories) { sub in
                                Text(sub.title.replacingOccurrences(of: "\(viewModel.selectedMainCategory) | ", with: ""))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        viewModel.didSelectSubCategory(sub)
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }

                    // Products Grid
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(viewModel.products) { product in
                                BrandProductCard(product: product)
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.loadMainCategories()
            }
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    CategoriesView()
}
