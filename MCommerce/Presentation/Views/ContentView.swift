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
//            UserDefaultsManager.shared.saveUserId("")
//            UserDefaultsManager.shared.setLoggedIn(false)
           }

    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//            Button("Test", action: {

              //  ApiCalling().callRestApi()
               // ApiCalling().createCustomer()

                //createCustomer()
           //     getCustomer()

//            })
//        }
//        .padding()
       
      //  HomeView()
//        MainTabView()
    //Register()
        
        if UserDefaultsManager.shared.isLoggedIn() {
            
         
                     HomeView()
            
                 } else {
                     WelcomeScreen()
                 }
    }
}

#Preview {
    ContentView()
}




