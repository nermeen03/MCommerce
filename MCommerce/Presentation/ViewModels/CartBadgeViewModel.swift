//
//  CartBadgeViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 22/06/2025.
//

import Foundation

class CartBadgeViewModel {
    static var shared = CartBadgeViewModel()
    private init() {}
    var badgeCount: Int = UserDefaultsManager.shared.getCartCount() ?? 0{
        willSet{
            UserDefaultsManager.shared.setCartBadgeCount(newValue)
        }
    }
}
