//
//  CategoriesView.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var viewModel = CategoriesViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search and cart bar
                HStack {
                    TextField("What do you search for?", text: .constant(""))
                        .padding(10)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)

                    Image(systemName: "cart")
                        .font(.title2)
                        .padding(.leading, 5)
                }
                .padding()

                HStack(spacing: 0) {
                    // Sidebar Main Categories
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.mainCategories) { category in
                                Text(category.title)
                                    .foregroundColor(category.title == viewModel.selectedMainCategory ? .blue : .black)
                                    .bold(category.title == viewModel.selectedMainCategory)
                                    .onTapGesture {
                                        viewModel.didSelectMainCategory(category)
                                    }
                            }
                            Spacer()
                        }
                        .padding(.top, 40)
                    }
                    .frame(width: 100)
                    .background(Color(UIColor.systemGray6))

                    // Main Content
                    VStack(alignment: .leading) {
                        // Product Type Filter
                        if !viewModel.productTypes.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Button("All") {
                                        viewModel.resetFilter()
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(viewModel.selectedProductType.isEmpty ? Color.blue.opacity(0.2) : Color.clear)
                                    .cornerRadius(8)

                                    ForEach(viewModel.productTypes, id: \.self) { type in
                                        Text(type)
                                            .padding(.horizontal)
                                            .padding(.vertical, 8)
                                            .background(viewModel.selectedProductType == type ? Color.blue.opacity(0.2) : Color.clear)
                                            .cornerRadius(8)
                                            .onTapGesture {
                                                viewModel.selectProductType(type)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }

                        // Current Category and Filter
                        Text(viewModel.selectedMainCategory + (viewModel.selectedProductType.isEmpty ? "" : " > \(viewModel.selectedProductType)"))
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 5)

                        // Product Grid
                        ScrollView {
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                                ForEach(viewModel.filteredProducts) { product in
                                    BrandProductCard(product: product,compact: true)
                                }
                            }
                            .padding()
                        }

                        Spacer()
                    }
                }
                .navigationBarHidden(true)
            }
            .onAppear {
                viewModel.loadMainCategories()
            }
        }
    }
}

#Preview {
    CategoriesView()
}
