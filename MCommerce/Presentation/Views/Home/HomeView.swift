//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: BrandsCoordinator
    @StateObject private var brandViewModel = DIContainer.shared.makeBrandViewModel()
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    BannerView()
                    BrandsView(viewModel: brandViewModel)
                    RecentlyViewedView()
                }
                .padding()
            }
            //        .padding(.bottom, 60)
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
