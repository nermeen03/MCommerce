//
//  MainTabView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    @EnvironmentObject private var connectivityManager: ConnectivityManager

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if connectivityManager.isConnected {
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
                } else {
                    NoInternetView()
                        .transition(.opacity)
                }
            }

            FloatingTabBar(selectedTab: $selectedTab)
        }
        .navigationBarHidden(true)
    }
}



//
//#Preview {
//    MainTabView()
//}
