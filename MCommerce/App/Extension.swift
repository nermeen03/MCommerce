//
//  Extension.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

extension String {
    var currency: String {
        let currentCurrency = UserDefaultsManager.shared.getCurrency()
        guard let value = Double(self) else { return self }
        let adjustedValue = currentCurrency == "USD" ? value / 50 : value
        return String(format: "%.2f", adjustedValue)
    }

    var symbol: String {
        let currentCurrency = UserDefaultsManager.shared.getCurrency()
        return currentCurrency == "USD" ? "$" : "EGP"
    }
}


extension Double {
    var currency: Double {
        let currentCurrency = UserDefaultsManager.shared.getCurrency()
      
        let adjustedValue = currentCurrency == "USD" ? self : self * 50
        return adjustedValue
    }

}

struct CurrencyFormatter {
    static func format(amountInEGP: Double) -> String {
        let currency = UserDefaultsManager.shared.getCurrency()
        
        let convertedAmount = currency == "USD" ? amountInEGP / 50 : amountInEGP
        let symbol = currency == "USD" ? "$" : "EGP"
        
        return "\(symbol)\(String(format: "%.2f", convertedAmount))"
    }
}
