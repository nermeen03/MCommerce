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
}

