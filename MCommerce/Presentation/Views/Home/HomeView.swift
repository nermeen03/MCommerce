//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI
import Alamofire

struct HomeView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var brandViewModel = DIContainer.shared.makeBrandViewModel()
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("Search products")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .onTapGesture {
                        coordinator.navigate(to: .search)
                    }
                    BannerView()
                    BrandsView(viewModel: brandViewModel)
                    RecentlyViewedView(products: $brandViewModel.suggestedProducts)
                }
                .padding()
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 50)
            }
        }.navigationTitle(Text("Home"))
            .padding(.top)

    }
}

#Preview {
    HomeView()
}
