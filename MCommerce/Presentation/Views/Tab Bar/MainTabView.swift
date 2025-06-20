//
//  MainTabView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @State private var cartBadgeCount: Int = 3
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    CategoriesView()
                case .cart:
                    CartView()
                case .favorites:
                    Text("Favorites")
                case .profile:
                    ProfileView()
                }
            }
            FloatingTabBar(selectedTab: $selectedTab, cartBadgeCount: cartBadgeCount)
        }.navigationBarHidden( true)
    }
}



#Preview {
    MainTabView()
}
