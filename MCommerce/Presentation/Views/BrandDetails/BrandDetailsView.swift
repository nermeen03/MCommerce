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
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var isFilterExpanded = false
   
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
              
                HStack{  SearchBarView(searchText: $viewModel.searchText)
                        ExpandedFilter(isFilterExpanded: $isFilterExpanded)
                }
                FilterBarView(
                              isExpanded: $isFilterExpanded,
                              selectedMaxPrice: $viewModel.selectedMaxPrice,
                              minPrice: $viewModel.minPrice,
                              maxPrice: $viewModel.maxPrice
                          )
                
                Text(brand.title)
                    .font(.system(size: 40, weight: .bold))

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.filteredProducts) { product in
                        BrandProductCard(product: product) .onTapGesture {
                            coordinator.navigate(to: .productInfo(product: product.id))
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


#Preview {
    BrandDetailsView(brand: Brand(id: "", title: "", imageUrl: ""), viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository()))
}
