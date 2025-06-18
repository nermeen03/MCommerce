//
//  ContentView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: BrandsCoordinator
    
    init() {
        if UserDefaultsManager.shared.isLoggedIn() {
            print("User ID: \(UserDefaultsManager.shared.getUserId() ?? "No ID")")
        }
    }
    
    var body: some View {
        if UserDefaultsManager.shared.isLoggedIn() {
            MainTabView()
                    .environmentObject(coordinator)
         } else {
            WelcomeScreen()
         }
    }    
}

#Preview {
    ContentView()
}




