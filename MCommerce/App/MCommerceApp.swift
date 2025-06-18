//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI
//import GoogleMobileAds

@main
struct MCommerceApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var coordinator = BrandsCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                    ContentView()
                        .environmentObject(coordinator)
                        .navigationDestination(for: Brand.self) { brand in
                            BrandDetailsView(
                                brand: brand,
                                viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository())
                            )
                        }
                }        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        MobileAds.shared.start(completionHandler: nil)
//        return true
//    }
//}
