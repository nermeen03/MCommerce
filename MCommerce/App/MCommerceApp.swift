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
    @StateObject var coordinator = AppCoordinator()
    @StateObject var currencyViewModel = CurrencyViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                 ContentView()
                        .navigationDestination(for: AppCoordinator.Destination.self) { destination in
                            switch destination {
                            case .welcome:
                                WelcomeScreen()
                            case .login:
                                Login()
                            case .signup:
                                Register()
                            case .logout:
                                WelcomeScreen()
                            case .home:
                                HomeView()
                            case .main:
                                MainTabView()
                            case .productInfo(let product):
                                ProductInfo(viewModel: DIContainer.shared.resolveProductInfoViewModel(id: product))
                            case .profile:
                                ProfileView()
                            case .setting:
                                SettingsView()
                            case .addressList:
                                AddressListView(viewModel:AddressViewModel())
                            case .addressForm(let address):
                                AddressFormView(defaultAddress: DefaultAddressViewModel(), viewModel: AddressViewModel(), address: address)
                            case .addressDetails(let address):
                                AddressDetailView(address: address)
                            case .brand(let brand):
                                BrandDetailsView(brand: brand, viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository()))
                            default:
                                CartView()
                            }
                        }
                }
                .environmentObject(coordinator)
                .environmentObject(currencyViewModel)
        }
        
    }
    
}
