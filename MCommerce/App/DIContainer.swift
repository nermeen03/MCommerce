//
//  DIContainer.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

final class DIContainer {
    static let shared = DIContainer()
    
    private lazy var apiCalling = ApiCalling()
    lazy var productRepository: ProductRepositoryProtocol = RemoteProductRepository(api: apiCalling)
    
    let discountViewModel: DiscountViewModel
    let profileViewModel : ProfileViewModel
    let settingsViewModel : SettingsViewModel
    let addressUseCase : AddressUseCases
    let defaultAddressUserCase : DefaultAddressUseCase
    let mapAddressUseCase : MapAddressUserCase
    let cartRepo : CartRepo
    var cartBadgeCount : CartBadgeViewModel = CartBadgeViewModel.shared
    
    //    let addressDetailsViewModel : AddressDetailViewModel
  
    private init() {
        self.discountViewModel = Self.resolveDiscountViewModel()
        self.profileViewModel = Self.resolveProfileViewModel()
        self.settingsViewModel = Self.resolveSettingsViewModel()
        self.addressUseCase = Self.resolveAddressUseCase()
        self.defaultAddressUserCase = Self.resolveDefaultAddressUseCase()
        self.mapAddressUseCase = Self.resolveMapAddressUseCase()
        self.cartRepo = Self.resolveCartRepo()
        //        self.addressDetailsViewModel = Self.resolveAddressDetailViewModel()
        
    }
    private static func resolveCartRepo() -> CartRepo {
        return CartRepo()
    }
    
    private static func resolveDiscountViewModel() -> DiscountViewModel {
        let remoteService = ApiCalling()
        let repository = DiscountRepository(remoteService: remoteService)
        let useCase = DiscountsUseCase(repository: repository)
        return DiscountViewModel(discountsUseCase: useCase)
    }
    
    func makeBrandViewModel() -> BrandViewModel {
        let remoteService = ApiCalling()
        let repository = BrandRepository(service: remoteService)
        return BrandViewModel(repository: repository)
    }
    
    func resolveProductInfoViewModel(id: String) -> ProductViewModel {
        let repository = ProductInfoRepo()
        let useCase = ProductInfoUseCase(repository: repository)
        let addUseseCase = AddFavProdUseCase(repo: ProductFavouriteRepository())
        let deleteUseseCase = DeleteFavProdUseCase(repo: ProductFavouriteRepository())
        let checkProductsUseCase = CheckFavouriteProdUseCase(repo: ProductFavouriteRepository())
        return ProductViewModel(useCase: useCase, id: id,deleteFavUseCase: deleteUseseCase, checkProductsUseCase: checkProductsUseCase ,AddFavUseCase: addUseseCase, cartUseCase: AddCartViewModel(addCartUseCase: AddInCartUseCase(cartRepo: CartRepo()), cartBadgeVM: cartBadgeCount))
    }
    func resolveFavoritesViewModel() -> FavoriteViewModel {
        let repo = ProductFavouriteRepository()
        let getprodUseCase = GetFavProdUseCase(repo: repo)
        let deleteUseCase = DeleteFavProdUseCase(repo: repo)
        return FavoriteViewModel(getProductsUseCase: getprodUseCase, deleteProductUseCase: deleteUseCase)
        
    }
    
    func resolveRegisterViewModel() -> RegisterViewModel {
        let repository = AuthenticationRepo()
        let useCase = RegisterUseCase(repository: repository)
        return RegisterViewModel(registerUseCase: useCase)
    }
    
    func resolveLoginViewModel() -> LoginViewModel {
        let repository = AuthenticationRepo()
        let useCase = LoginUseCase(repository: repository)
        return LoginViewModel(useCase: useCase)
    }
    private static func resolveProfileViewModel() -> ProfileViewModel {
        let orderRepo = OrderRepo()
        let orderUseCase = getOrderUseCase(orderRepo: orderRepo)
        let orderViewModel = ProfileOrderViewModel(getOrderUseCase: orderUseCase)
        
        let favRepo = ProductFavouriteRepository()
        let favUseCase = GetFavProdUseCase(repo: favRepo)
        let favViewModel = ProfileFavouriteViewModel(getFavUseCase: favUseCase)
        return ProfileViewModel(favViewModel: favViewModel, orderViewModel: orderViewModel)
    }
    
    func resolveProfile() -> some View{
        return ProfileView(profileViewModel: self.profileViewModel)
    }
    
    
    
    
    private static func resolveSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(addressViewModel: DefaultAddressUseCase(),currencyViewModel: CurrencyViewModel())
    }
    
    func resolveSettings() -> some View{
        return SettingsView(settingsViewModel: settingsViewModel)
    }
    
    private static func resolveAddressUseCase() -> AddressUseCases {
        return AddressUseCases()
    }
    
    private static func resolveDefaultAddressUseCase() -> DefaultAddressUseCase {
        return DefaultAddressUseCase()
    }
    
    private static func resolveMapAddressUseCase() -> MapAddressUserCase {
        return MapAddressUserCase()
    }
    
    func resolveAddressFormViewModel(addressDetailsViewModel:AddressDetailViewModel?) -> AddressFormViewModel{
        return AddressFormViewModel(defaultUseCase: defaultAddressUserCase, mapAddressUseCase: mapAddressUseCase, addressUseCases: addressUseCase, addressDetailViewModel: addressDetailsViewModel)
    }
    
    func resolveAddressDetailViewModel(address : AddressInfo) -> AddressDetailViewModel{
        return AddressDetailViewModel(address: address)
    }
    
    func resolveAddressDetailView(addressDetailsViewModel : AddressDetailViewModel) -> some View{
        return AddressDetailView(addressViewModel: addressDetailsViewModel)
    }
    
    func resolveAddressFormView(addressDetailViewModel:AddressDetailViewModel?) -> some View{
        return AddressFormView(viewModel: self.resolveAddressFormViewModel(addressDetailsViewModel: addressDetailViewModel))
    }
    
    func resolveAddressListView() -> some View{
        return AddressListView(viewModel: AddressViewModel(addressUseCases: self.addressUseCase))
    }
    
    func resolveCartView() -> some View{
        return CartListView(cartViewModel: GetCartViewModel(getCartUseCase: GetCartUseCase(cartRepo: cartRepo), cartBadgeVM: cartBadgeCount, addCartVM: AddCartViewModel(addCartUseCase: AddInCartUseCase(cartRepo: CartRepo()), cartBadgeVM: cartBadgeCount)))
    }
    
    func resolveFavView() -> some View{
        return FavView(viewModel: FavoriteViewModel(getProductsUseCase: GetFavProdUseCase(repo: ProductFavouriteRepository()), deleteProductUseCase: DeleteFavProdUseCase(repo: ProductFavouriteRepository())))
    }
    func resolveCartBadgeCount() -> CartBadgeViewModel {
        return cartBadgeCount
    }
}
