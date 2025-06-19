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
    @Environment(\.modelContext) var modelContext

    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                Spacer()
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
//            .onAppear {
//                            for i in 0..<10 {
//                                let product = FavProductInfo(
//                                    userId: "userId",
//                                    productId: UUID().uuidString, // ✅ Make each one unique
//                                    productImage: nil,
//                                    productName: "TestProduct \(i)"
//                                )
//                                modelContext.insert(product)
//                            }
//                
//                            try? modelContext.save() // ✅ MUST SAVE
//                        }

            Divider()
                .padding(.bottom, 8)
            if loggedIn {
                ScrollView{
                    VStack {
                        //                        let userName = UserDefaultsManager.shared.getUserName() ?? "User"
                        let userName = "User"
                        HStack(alignment: .center, content: {
                            Text("Welcome \(userName)").font(.title)
                        })
                        OrdersView(viewModel: OrderViewModel())
                        WishListView().modelContainer(for: FavProductInfo.self)
                    }
                }.onAppear {
                    for i in 0..<10 {
                        let product = FavProductInfo(
                            userId: "userId",
                            productId: UUID().uuidString, // ✅ Make each one unique
                            productImage: "",
                            productName: "TestProduct \(i)"
                        )
                        modelContext.insert(product)
                    }
        
                    try? modelContext.save() // ✅ MUST SAVE
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
}

#Preview {
    ProfileView()
}
