//
//  MyOrderView.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.

import SwiftUI

struct MyOrderView: View {
    @ObservedObject var viewModel: ProfileOrderViewModel
    @State private var selectedTab = 0
    @EnvironmentObject var coordinator: AppCoordinator

    var filteredOrders: [OrderDataResponse] {
        selectedTab == 0
            ? viewModel.orders.filter { $0.status.lowercased() != "completed" }
            : viewModel.orders.filter { $0.status.lowercased() == "completed" }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Custom TabBar
                HStack {
                    Button(action: { selectedTab = 0 }) {
                        Text("Open")
                            .font(.headline)
                            .foregroundColor(selectedTab == 0 ? .black : .gray)
                    }
                    Spacer()
                    Button(action: { selectedTab = 1 }) {
                        Text("Completed")
                            .font(.headline)
                            .foregroundColor(selectedTab == 1 ? .black : .gray)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 30)
                } else if filteredOrders.isEmpty {
                    Text("No Orders Found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredOrders) { order in
                                OrderListCard(order: order)
                                    .onTapGesture {
                                        coordinator.navigate(to: .orderDetails(order))
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("My Order")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getOrder()
        }
    }
}

