//
//  SettingsViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import Foundation
import CoreLocation
import SwiftUI

class SettingsViewModel : ObservableObject{
    
    @Published var defaultAddress : AddressInfo?
    
    let addressViewModel : DefaultAddressUseCase
    let currencyViewModel: CurrencyViewModel

    init(addressViewModel: DefaultAddressUseCase, currencyViewModel: CurrencyViewModel) {
        self.addressViewModel = addressViewModel
        self.currencyViewModel = currencyViewModel
    }
    
    func reloadAllSettings() {
        addressViewModel.getDefaultAddress(completion: {[weak self] result in
            self?.defaultAddress = result
        })
        currencyViewModel.reloadCurrency()
    }
    
    
}



class CurrencyViewModel: ObservableObject {
    @Published var currentCurrency: String = UserDefaultsManager.shared.getCurrency()
    
    let availableCurrencies = ["EGP", "USD"]

    func selectCurrency(_ currency: String) {
        UserDefaultsManager.shared.saveCurrency(currency)
        currentCurrency = currency
    }
    func reloadCurrency() {
        currentCurrency = UserDefaultsManager.shared.getCurrency()
    }

}
