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

    var displayedOrders: [OrderDataResponse] {
        Array(viewModel.orders.prefix(showAllOrders ? viewModel.orders.count : 2))
    }

    var body: some View {
        VStack {
            header

            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.orders.isEmpty {
                Text("No Orders Found")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        ForEach(displayedOrders) { order in
                            orderCard(for: order)
                        }
                    }
                    .padding(25)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Text("My Orders").font(.headline)
            Spacer()
            if viewModel.orders.count > 2 {
                Button(showAllOrders ? "Read More" : "Read More") {
//                    showAllOrders.toggle()
                    coordinator.navigate(to: .myOrders)
                }
                .font(.headline)
            }
        }
        .padding()
    }

    @ViewBuilder
    private func orderCard(for order: OrderDataResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = order.items.first?.imageURL, let url = URL(string: urlString) {
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

            Text("\(order.total) \(order.currencyCode)")
                .font(.headline)

            Text(order.dateFormatted)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
            coordinator.navigate(to: .orderDetails(order))
        }
    }
}
