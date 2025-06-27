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
                
                if viewModel.searchText.isEmpty{
                   
                    VStack(alignment: .center){
                        LottieView(animationName: "tradia")
                            .frame(width: 200, height: 200)
                        Text("What are you looking for ?")
                        .font(.title).bold().foregroundColor(.gray)}.padding(.top , 64)
                    
                        
                }
                else {
                if !viewModel.filteredProductPrice.isEmpty{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.filteredProductPrice) { product in
                            SearchProductCard(product: product) .onTapGesture {
                                coordinator.navigate(to: .productInfo(product: product.id))
                            }
                        }   }
                    }
                    else{
                        Text("No result found")
                            .font(.title).bold().foregroundColor(.gray).padding(.top , 264)
                    }
                
                }
            }
            }.padding()
        
    }
}

#Preview {
    SearchView()
}
