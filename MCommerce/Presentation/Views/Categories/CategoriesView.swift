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
                    .frame(width: 70)
                    .background(Color(UIColor.systemGray6))
                    // Main Content
                    VStack(alignment: .leading) {
                        // Subcategory
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.subCategories.filter { $0.parentCategory == viewModel.selectedMainCategory }) { sub in
                                    Text(sub.title.components(separatedBy: " | ").last ?? sub.title)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(viewModel.selectedSubCategory == sub.title ? Color.blue.opacity(0.2) : Color.clear)
                                        .cornerRadius(8)
                                        .onTapGesture {
                                            viewModel.didSelectSubCategory(sub)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }

                        Text("\(viewModel.selectedMainCategory) > \(viewModel.selectedSubCategory.components(separatedBy: " | ").last ?? viewModel.selectedSubCategory)")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 5)

                        // Product Grid
                        ScrollView {
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                                ForEach(viewModel.products) { product in
                                    BrandProductCard(product: product)
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
