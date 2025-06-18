//
//  Coordinator.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//
import SwiftUI

final class BrandsCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToProducts(for brand: Brand) {
        path.append(brand)
    }
}
