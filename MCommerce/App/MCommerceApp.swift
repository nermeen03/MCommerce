//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//


import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MCommerceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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

