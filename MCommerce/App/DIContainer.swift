//
//  DIContainer.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

final class DIContainer {
    static let shared = DIContainer()

    private lazy var apiCalling = ApiCalling()
    lazy var productRepository: ProductRepositoryProtocol = RemoteProductRepository(api: apiCalling)

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

    func resolveProductInfoViewModel(id: String) -> ProductViewModel {
        let repository = ProductInfoRepo()
        let useCase = ProductInfoUseCase(repository: repository)
        return ProductViewModel(useCase: useCase, id: id)
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
