//
//  SearchView.swift
//  MCommerce
//
//  Created by Jailan Medhat on 21/06/2025.
//

import SwiftUI

struct HomeSearchView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var viewModel : HomeSearchViewModel
    @State var isExpanded: Bool = false
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    SearchBarView(searchText: $viewModel.searchText)
                    ExpandedFilter(isFilterExpanded: $isExpanded)
                }
                FilterBarView(isExpanded: $isExpanded, selectedMaxPrice: $viewModel.selectedMaxPrice, minPrice: $viewModel.minPrice, maxPrice : $viewModel.maxPrice)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.filteredProductPrice) { product in
                        SearchProductCard(product: product) .onTapGesture {
                            coordinator.navigate(to: .productInfo(product: product.id))
                        }
                    }
                }}
        }.padding()
        
    }
}

#Preview {
    SearchView()
}
