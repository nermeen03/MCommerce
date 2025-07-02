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
    @StateObject private var cartVM = CartBadgeVM.shared
    @StateObject private var connectivityManager = ConnectivityManager.shared
    @State private var showAlert = false
    @State private var alertMessage = ""

    init() {
        if UserDefaultsManager.shared.isLoggedIn() {
            print("User ID: \(UserDefaultsManager.shared.getUserId() ?? "No ID")")
        }
    }

    private func setupConnectivity() {
        connectivityManager.setupConnectivity()
    }

    private func stopConnectivity() {
        connectivityManager.stopConnectivity()
    }

    private func connectivityAlert() -> Alert {
        Alert(
            title: Text(connectivityManager.isConnected ? "Internet!" : "No Internet!"),
            message: Text(alertMessage),
            dismissButton: .default(Text("OK"))
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                ContentView()
                    .navigationDestination(for: AppCoordinator.Destination.self) { destination in
                        switch destination {
                        case .welcome:
                            LazyView { WelcomeScreen() }
                        case .login:
                            LazyView { Login() }
                        case .signup:
                            LazyView { Register() }
                        case .logout:
                            LazyView { WelcomeScreen() }
                        case .home:
                            LazyView { HomeView() }
                        case .main:
                            LazyView { MainTabView() }
                        case .productInfo(let product):
                            LazyView { ProductInfoView(viewModel: DIContainer.shared.resolveProductInfoViewModel(id: product)) }
                        case .profile:
                            LazyView { DIContainer.shared.resolveProfile() }
                        case .setting:
                            LazyView { DIContainer.shared.resolveSettings() }
                        case .addressList:
                            LazyView { DIContainer.shared.resolveAddressListView() }
                        case .addressForm(let address):
                            LazyView { DIContainer.shared.resolveAddressFormView(addressDetailViewModel: address) }
                        case .addressDetails(let address):
                            LazyView { AddressDetailView(addressViewModel: address) }
                        case .brand(let brand):
                            LazyView { BrandDetailsView(brand: brand, viewModel: BrandDetailsViewModel(repository: BrandDetailsRepository())) }
                        case .cart:
                            LazyView { DIContainer.shared.resolveCartView() }
                        case .favorites:
                            LazyView { DIContainer.shared.resolveFavView() }
                        case .search:
                            LazyView { DIContainer.shared.resolveHomeSearchView() }
                        case .checkout(let price, let items):
                            LazyView { CheckoutView(viewModel: CheckoutViewModel(addressUseCases: AddressUseCases()), totalPrice: price, items: items) }
                        case .orderDetails(let order):
                            LazyView { OrderDetailsView(order: order) }
                        case .myOrders:
                            LazyView { MyOrderView(viewModel: ProfileOrderViewModel(getOrderUseCase: getOrderUseCase(orderRepo: OrderRepo()))) }
                        case .onBoarding:
                            LazyView{ OnboardingView()}
                        }
                    }
            }
            .environmentObject(coordinator)
            .environmentObject(currencyViewModel)
            .environmentObject(cartVM)
            .environmentObject(connectivityManager)
            .onAppear {
                setupConnectivity()
            }
            .onDisappear {
                stopConnectivity()
            }
            .onChange(of: connectivityManager.isConnected) { isConnected in
                alertMessage = isConnected ? "You are connected to the internet." : "No internet connection available."
                showAlert = true
            }
            .alert(isPresented: $showAlert, content: connectivityAlert)
        }
    }
}
