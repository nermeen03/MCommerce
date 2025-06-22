//
//  OrdersView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject var viewModel: ProfileOrderViewModel
    @State private var showAllOrders = false
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        
        HStack{
            Text("My Orders").font(.headline)
            Spacer()
            if viewModel.orders.count > 2 {
                Button(showAllOrders ? "Show Less" : "Read More") {
                    showAllOrders.toggle()
                }
                .font(.headline)
            }
        }.padding()
        
        if viewModel.isLoading {
            ProgressView()
        } else if viewModel.orders.isEmpty {
            Text("No Orders Found")
        } else {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(viewModel.orders.prefix(showAllOrders ? viewModel.orders.count : 2)) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            
                            if let urlString = order.productImage, let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(width: 120, height: 120)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 120)
                                            .clipped()
                                            .cornerRadius(8)
                                        
                                    case .failure:
                                        Color.gray.frame(width: 120, height: 120)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            } else {
                                Color.gray.frame(width: 120, height: 120)
                                    .cornerRadius(8)
                            }
                            
                            Text("\(order.price) \(order.currencyCode)")
                                .font(.headline)
                            
                            Text(order.date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(width: 150)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                    }
                }
                .padding(25)
            }
        }
    }
}

