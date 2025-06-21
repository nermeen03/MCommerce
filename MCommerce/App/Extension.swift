//
//  Extension.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

extension String {
    var currency: String {
        let currentCurrency = UserDefaultsManager.shared.getCurrency() ?? "USD"
        guard let value = Double(self) else { return self }
        
        let adjustedValue = currentCurrency == "USD" ? value : value * 50
        return String(format: "%.2f", adjustedValue)
    }
    var symbol: String {
    
        let currentCurrency = UserDefaultsManager.shared.getCurrency() ?? "USD"
        let adjustedValue = currentCurrency == "USD" ? "$" : "EGP"
        return adjustedValue
    }
}

extension Double {
    var currency: Double {
        let currentCurrency = UserDefaultsManager.shared.getCurrency() ?? "USD"
        
        let adjustedValue = currentCurrency == "USD" ? self : self * 50
        return adjustedValue
    }

}
