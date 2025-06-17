//
//  DiscountViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUICore

class DiscountViewModel : ObservableObject{
        
    @Published var discounts: [DiscountData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let discountsUseCase : DiscountsUseCaseProtocol
    
    init(discountsUseCase: DiscountsUseCaseProtocol) {
        self.discountsUseCase = discountsUseCase
    }
    
    func fetchDiscounts() {
        isLoading = true
        errorMessage = nil
        discountsUseCase.getDiscount { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let discounts):
                    self?.discounts = discounts
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
