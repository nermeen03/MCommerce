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
        
        if UserDefaultsManager.shared.getCartCount() == nil {
            FirebaseFirestoreHelper.shared.fetchBadgeCount { [weak self] fetchedCount in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.badgeCount = fetchedCount
                }
            }
        }
    }

    @Published var badgeCount: Int {
        willSet {
            FirebaseFirestoreHelper.shared.saveOrUpdateBadgeCount(newValue)
            UserDefaultsManager.shared.setCartBadgeCount(newValue)
        }
    }
}


