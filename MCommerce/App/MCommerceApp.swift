//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//


import SwiftUI

@main
struct MCommerceApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @StateObject var coordinator = BrandsCoordinator()

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                NavigationStack(path: $coordinator.path) {
                    ContentView()
                    .environmentObject(coordinator)
                    .navigationDestination(for: Brand.self) { brand in
                        BrandDetailsView(
                            brand: brand,
                            viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository())
                        )
                    }
                }
            } else{
                WelcomeScreen()
            }
        }
    }
}
