//
//  AppCoordinator.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    enum Destination: Hashable {
        case welcome
        case login
        case signup
        case logout
        case main
        case home
        case productInfo(product : String)
        case brand(brand:Brand)
        case profile
        case favorites
        case cart
        case setting
        case addressList
        case addressForm(address: AddressDetailViewModel?)
        case addressDetails(address: AddressDetailViewModel)
        
    }
    
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
}
