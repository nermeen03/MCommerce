//
//  CartBadgeViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 22/06/2025.
//

import Foundation
import SwiftUI

class CartBadgeVM: ObservableObject {
    static let shared = CartBadgeVM()
    private init() {
        self.badgeCount = UserDefaultsManager.shared.getCartCount() ?? 0
        
    }

    @Published var badgeCount: Int {
        willSet {
            FirebaseFirestoreHelper.shared.saveOrUpdateBadgeCount(newValue)
            UserDefaultsManager.shared.setCartBadgeCount(newValue)
        }
    }
}


