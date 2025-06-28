//
//  MainTabView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .search:
                    CategoriesView()
                case .cart:
                    DIContainer.shared.resolveCartView()
                case .profile:
                    DIContainer.shared.resolveProfile()
                }
            }
            FloatingTabBar(selectedTab: $selectedTab, cartBadgeVM: DIContainer.shared.resolveCartBadgeCount())
        }.navigationBarHidden( true)
    }
}


//
//#Preview {
//    MainTabView()
//}
