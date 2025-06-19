//
//  DIContainer.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

final class DIContainer {
    static let shared = DIContainer()

    let discountViewModel: DiscountViewModel

    private init() {
        self.discountViewModel = Self.resolveDiscountViewModel()
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
    func resolveProductInfoViewModel(id :String) -> ProductViewModel {
      
        let repository = ProductInfoRepo()
        let useCase = ProductInfoUseCase(repository: repository)
        let ProductInfoViewModel = ProductViewModel(useCase: useCase, id: id)
        return ProductInfoViewModel
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
}

