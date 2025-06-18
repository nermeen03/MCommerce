//
//  MCommerceApp.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

@main
struct MCommerceApp: App {
   
    var body: some Scene {
        WindowGroup {
            
            if UserDefaultsManager.shared.isLoggedIn() {
                
                
                // ProductInfo()
                 HomeView()
              //  Register()
                
            } else {
               WelcomeScreen()
            }
        }
        }
    }

