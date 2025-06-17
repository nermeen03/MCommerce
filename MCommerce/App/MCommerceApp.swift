//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

@main
struct MCommerceApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
            } else{
                WelcomeScreen()
            }
        }
    }
}
