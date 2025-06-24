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
//            PaymentView()
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
                                ProductInfoView(viewModel: DIContainer.shared.resolveProductInfoViewModel(id: product))
                            case .profile:
                                DIContainer.shared.resolveProfile()
                            case .setting:
                                DIContainer.shared.resolveSettings()
                            case .addressList:
                                DIContainer.shared.resolveAddressListView()
                            case .addressForm(let address):
                                DIContainer.shared.resolveAddressFormView(addressDetailViewModel: address)
                            case .addressDetails(let address):
                                AddressDetailView(addressViewModel: address)
                            case .brand(let brand):
                                BrandDetailsView(brand: brand, viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository()))
                            case .cart:
                                DIContainer.shared.resolveCartView()
                            case .favorites:
                                DIContainer.shared.resolveFavView()
                            case .search:
                                DIContainer.shared.resolveHomeSearchView()
                            }
                        }
                }
                .environmentObject(coordinator)
                .environmentObject(currencyViewModel)
        }
        
    }
    
}
