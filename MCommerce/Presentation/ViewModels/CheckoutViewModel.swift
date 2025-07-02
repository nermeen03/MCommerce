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
    @Published var isAddressesLoading : Bool = false
    
//    @Published var orderPlaced = false
//    @Published var orderMessage: String = ""
//    
//    @Published var showAddressAlert = false
    @Published var activeAlert: CheckoutAlert? = nil
    @Published var alertMessage: String = ""

    

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
                    print("No addresses found, showing alert.")
                } else {
                    print("Addresses fetched successfully.") 
                }
            }
        }
    }

    
    func placeOrder(items : [CartItem]){
        guard let selectedAddress = selectedAddress else {
            self.activeAlert = .noAddress
            self.alertMessage = "Please enter an address before placing the order"
            return
        }
        OrderRepo().createOrder(
            customerId: UserDefaultsManager.shared.getUserId() ?? "",
            cartItems: items,
            shippingAddress: selectedAddress, paymentMethod: selectedPaymentMethod.rawValue, discount: discountPercentage
        ) { result in
            self.setOrderPlacedMessage()
        }
    }
    
    func setPaymentError() {
        activeAlert = .paymentError
        alertMessage = "Payment was canceled"
    }
    
    func setOrderPlacedMessage() {
        activeAlert = .orderPlaced
        alertMessage = "Your order has been placed successfully!"
    }
    
    func setNoAddressMessage() {
        activeAlert = .noAddress
        alertMessage = "You need to add an address first."
    }
    
}

enum CheckoutAlert: Identifiable {
    case paymentError
    case orderPlaced
    case noAddress

    var id: String {
        switch self {
        case .paymentError: return "paymentError"
        case .orderPlaced: return "orderPlaced"
        case .noAddress: return "noAddress"
        }
    }
}

