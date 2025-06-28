//
//  CheckoutViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 25/06/2025.
//

import Foundation
class CheckoutViewModel: ObservableObject {
    @Published var selectedAddressId: String?
    @Published var selectedAddress: ShippingAddress?
    @Published var selectedPaymentMethod: PaymentMethod = .cod
    @Published var couponCode: String = ""
    @Published var isCouponApplied: Bool = false
    @Published var discountPercentage: Double = 0.0
    
    var addressUseCases : AddressUseCases
    
    init(addressUseCases: AddressUseCases) {
        self.addressUseCases = addressUseCases
    }
    
    @Published var addresses : [AddressInfo] = []
    @Published var isAddressesLoading : Bool = true
    
    @Published var orderPlaced = false
    @Published var orderMessage: String = ""
    
    @Published var showAddressAlert = false

    

    enum PaymentMethod: String, Identifiable {
        case cod = "Cash on Delivery"
        case stripe = "Other (Card / Apple Pay)"
        
        var id: String { rawValue } 
    }

    func applyCoupon(_ code: String) {
        let coupons: [String: Double] = [
            "save30": 0.30,
            "flash10": 0.10,
            "weekend25": 0.25
        ]
        
        let lowercasedCode = code.lowercased()
        
        if let discount = coupons[lowercasedCode] {
            discountPercentage = discount
            isCouponApplied = true
        } else {
            discountPercentage = 0.0
            isCouponApplied = false
        }
    }
    
    func fetchAddresses() {
        isAddressesLoading = true
        addressUseCases.getFromFireStore { [weak self] result in
            DispatchQueue.main.async {
                self?.addresses = result
                self?.isAddressesLoading = false
                if result.isEmpty {
                    self?.showAddressAlert = true  // Must be on main thread
                }
            }
        }
    }

    
    func placeOrder(items : [CartItem]){
        OrderRepo().createOrder(
            customerId: UserDefaultsManager.shared.getUserId() ?? "",
            cartItems: items,
            shippingAddress: selectedAddress!, paymentMethod: selectedPaymentMethod.rawValue, discount: discountPercentage
        ) { result in
            self.orderPlaced = true
            self.orderMessage = result
        }
    }
    
    
}
