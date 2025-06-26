////
////  MyOrderView.swift
////  MCommerce
////
////  Created by abram on 21/06/2025.
////
//
//import SwiftUI
//
//struct OrderItem: Identifiable {
//    let id = UUID()
//    let imageName: String
//    let title: String
//    let color: String
//    let quantity: Int
//    let price: Double
//    let status: String
//}
//
//struct MyOrderView: View {
//    let orders: [OrderItem] = [
//        OrderItem(imageName: "bag1", title: "Bix Bag Limited Edition 229", color: "Berown", quantity: 1, price: 24.00, status: "On Progress"),
//        OrderItem(imageName: "bag2", title: "Bix Bag 319", color: "Berown", quantity: 1, price: 21.50, status: "On Progress")
//    ]
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                // TabBar style: My Order / History
//                HStack {
//                    Text("My Order")
//                        .font(.headline)
//                        .foregroundColor(.black)
//                    Spacer()
//                    Text("History")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                }
//                .padding(.horizontal)
//                .padding(.top, 10)
//                
//                // Purple underline for selected tab
//                Rectangle()
//                    .fill(Color.purple)
//                    .frame(height: 2)
//                    .padding(.horizontal)
//                
//                ScrollView {
//                    VStack(spacing: 16) {
//                        ForEach(orders) { order in
//                            OrderCard(order: order)
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .navigationTitle("My Order")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "bag")
//                }
//            }
//        }
//    }
//}
//
//
//#Preview {
//    MyOrderView()
//}
