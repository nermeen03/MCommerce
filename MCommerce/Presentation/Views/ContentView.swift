//
//  ContentView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    init() {
        if UserDefaultsManager.shared.isLoggedIn() {
            print("User ID: \(UserDefaultsManager.shared.getUserId() ?? "No ID")")
        }
    }

    var body: some View {
        if UserDefaultsManager.shared.isLoggedIn() {
            MainTabView()
         } else {
             OnboardingView()
         }
    }    
}





