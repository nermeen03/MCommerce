//
//  ProfileView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

//import SwiftUI
//
//struct ProfileView: View {
//    @EnvironmentObject var coordinator: AppCoordinator
//    let loggedIn = UserDefaultsManager.shared.isLoggedIn()
//
//    var profileViewModel : ProfileViewModel
//    
//    var body: some View {
//        VStack{
//            
//            HStack {
//                if loggedIn {
//                    Spacer()
//                }
//
//                if loggedIn {
//                    Text("Profile")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding(.horizontal).padding(.leading, 20)
//                    Spacer()
//                    Button(action: {
//                        coordinator.navigate(to: .setting)
//                    }) {
//                        Image(systemName: "gear")
//                            .padding(8)
//                            .background(Color.gray.opacity(0.2))
//                            .clipShape(Circle())
//                    }
//                }
//
//                if !loggedIn {
//                    Text("Profile")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding(.horizontal)
//                    Spacer()
//                }
//            }
//            .padding(.horizontal)
//            .onAppear{
//                profileViewModel.getData()
//            }
//
//            Divider()
//                .padding(.bottom, 8)
//            if loggedIn {
//                ScrollView{
//                    VStack {
//                        let userName = UserDefaultsManager.shared.getFirstName() ?? "User"
//                        HStack(alignment: .center, content: {
//                            Text("Welcome \(userName)").font(.title).padding()
//                        })
//                        OrdersView(viewModel: profileViewModel.orderViewModel)
//                        WishListView(favViewModel: profileViewModel.favViewModel)
//                        Spacer()
//                    }
//                }
//            }else{
//                VStack(alignment: .center, content: {
//                    HStack(alignment: .center, content: {
//                        Text("Welcome Guest").font(.title)
//                    }).padding(.bottom , 64)
//                    Button(action: {
//                        coordinator.navigate(to: .login)
//                    }) {
//                        Text("Login")
//                            .font(.system(size: 24, weight: .heavy))
//                            .frame(width: UIScreen.main.bounds.width - 200, height: 90)
//                            .foregroundColor(.yellow)
//                            .background(Color.blue)
//                            .cornerRadius(12)
//                    }
//
//                    Button(action: {
//                        coordinator.navigate(to: .signup)
//                    }) {
//                        Text("Register")
//                            .font(.system(size: 24, weight: .heavy))
//                            .frame(width: UIScreen.main.bounds.width - 200, height: 90)
//                            .foregroundColor(.blue)
//                            .background(Color.yellow)
//                            .cornerRadius(12)
//                    }
//                    Spacer()
//                })
//            }
//        }
//    }
//}
//
////#Preview {
////    ProfileView()
////}
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let loggedIn = UserDefaultsManager.shared.isLoggedIn()

    var profileViewModel : ProfileViewModel // Make sure this is initialized

    var body: some View {
        VStack {
            HStack {
                if loggedIn {
                    Spacer()
                }

                if loggedIn {
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    Spacer()
                    Button(action: {
                        coordinator.navigate(to: .setting)
                    }) {
                        Image(systemName: "gear")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }

                if !loggedIn {
                    Text("Profile")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .onAppear {
                profileViewModel.getData()
            }

            Divider()
                .padding(.bottom, 8)

            if loggedIn {
                ScrollView {
                    VStack {
                        let userName = UserDefaultsManager.shared.getFirstName() ?? "User"
                        HStack(alignment: .center, content: {
                            Text("Welcome \(userName)").font(.title).padding()
                        })
                        OrdersView(viewModel: profileViewModel.orderViewModel)
                        WishListView(favViewModel: profileViewModel.favViewModel)
                        Spacer()
                    }
                }
            } else {
                VStack(alignment: .center) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 16)
                    Button(action: {
                        coordinator.navigate(to: .signup)
                    }) {
                        Text("Create account")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.deepPurple)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)

                    Button(action: {
                        coordinator.navigate(to: .login)
                    }) {
                        Text("Sign in")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    .fill(Color.gray.opacity(0.1))
                            )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                    VStack(alignment: .leading, spacing: 25) {
                        BenefitRow(imageName: "shippingbox.fill", text: "Free Delivery on first order")
                        BenefitRow(imageName: "arrow.triangle.2.circlepath", text: "Easy Returns")
                        BenefitRow(imageName: "creditcard.fill", text: "Faster Checkout")
                        BenefitRow(imageName: "hand.raised.square.fill", text: "Personalized Recommendations")
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
        }
    }
}

struct BenefitRow: View {
    let imageName: String
    let text: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
            Text(text)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
        }
    }
}
