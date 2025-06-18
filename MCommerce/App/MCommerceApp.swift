//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//


import SwiftUI

@main
struct MCommerceApp: App {

    @StateObject var coordinator = BrandsCoordinator()

    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager.shared.isLoggedIn() {
                NavigationStack(path: $coordinator.path) {
                 ContentView()
                        .navigationDestination(for: Brand.self) { brand in
                            BrandDetailsView(
                                brand: brand,
                                viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository())
                            )
                        }
                        .navigationDestination(for: String.self) { productId in
                            ProductInfo(viewModel: DIContainer.shared.resolveProductInfoViewModel(id: productId))
                        }
                }
                .environmentObject(coordinator)
            }else{
                NavigationStack(path: $coordinator.path) {
                    WelcomeScreen()
                        .navigationDestination(for: Brand.self) { brand in
                            BrandDetailsView(
                                brand: brand,
                                viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository())
                            )
                        }
                        .navigationDestination(for: String.self) { productId in
                            ProductInfo(viewModel: DIContainer.shared.resolveProductInfoViewModel(id: productId))
                        }
                }
                .environmentObject(coordinator)
            }
        }
        }
    }

