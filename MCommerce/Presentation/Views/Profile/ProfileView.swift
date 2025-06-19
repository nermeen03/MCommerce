//
//  ProfileView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct ProfileLoggedView: View {
    
    let loggedIn = UserDefaultsManager.shared.isLoggedIn()

    var body: some View {
        if loggedIn {
            ScrollView{
                VStack {
                    let userName = UserDefaultsManager.shared.getUserName() ?? "User"
                    HStack(alignment: .center, content: {
                        Text("Welcome \(userName)").font(.title)
                    })
                    OrdersView(viewModel: OrderViewModel())
                    WishListView().modelContainer(for: FavProductInfo.self)
                }
            }
        }else{
            VStack(alignment: .center, content: {
                Button(action: {
                }) {
                    Text("Login")
                        .font(.system(size: 40, weight: .heavy))
                        .frame(width: UIScreen.main.bounds.width - 200, height: 90)
                        .foregroundColor(.yellow)
                        .background(Color.blue)
                        .cornerRadius(12)
                }

                Button(action: {
                }) {
                    Text("Register")
                        .font(.system(size: 40, weight: .heavy))
                        .frame(width: UIScreen.main.bounds.width - 200, height: 90)
                        .foregroundColor(.blue)
                        .background(Color.yellow)
                        .cornerRadius(12)
                }
            })
        }
    }
}

#Preview {
    ProfileLoggedView()
}
