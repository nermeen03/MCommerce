//
//  ProfileView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let loggedIn = UserDefaultsManager.shared.isLoggedIn()

    var profileViewModel : ProfileViewModel
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("Profile")
                    .font(.largeTitle)
                    .bold().padding(.trailing,50)
                Button(action: {
                    print("Favorite")
                }) {
                    Image(systemName: "cart")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }

                Button(action: {
                    coordinator.navigate(to: .setting)
                }) {
                    Image(systemName: "gear")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .onAppear{
                profileViewModel.getData()
            }

            Divider()
                .padding(.bottom, 8)
            if loggedIn {
                ScrollView{
                    VStack {
                        let userName = UserDefaultsManager.shared.getFirstName() ?? "User"
                        HStack(alignment: .center, content: {
                            Text("Welcome \(userName)").font(.title)
                        })
                        OrdersView(viewModel: profileViewModel.orderViewModel)
                        WishListView(favViewModel: profileViewModel.favViewModel)
                        Spacer()
                    }
                }
            }else{
                VStack(alignment: .center, content: {
                    HStack(alignment: .center, content: {
                        Text("Welcome Guest").font(.title)
                    }).padding(.bottom , 64)
                    Button(action: {
                        coordinator.navigate(to: .login)
                    }) {
                        Text("Login")
                            .font(.system(size: 24, weight: .heavy))
                            .frame(width: UIScreen.main.bounds.width - 200, height: 90)
                            .foregroundColor(.yellow)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        coordinator.navigate(to: .signup)
                    }) {
                        Text("Register")
                            .font(.system(size: 24, weight: .heavy))
                            .frame(width: UIScreen.main.bounds.width - 200, height: 90)
                            .foregroundColor(.blue)
                            .background(Color.yellow)
                            .cornerRadius(12)
                    }
                    Spacer()
                })
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
