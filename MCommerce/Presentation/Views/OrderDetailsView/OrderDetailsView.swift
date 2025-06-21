//
//  OrderDetailsView.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//

import SwiftUI

struct OrderDetailsView: View {
    var order: OrderModel = sampleOrder

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Vendor Info
                VStack(spacing: 8) {
                    Image(order.storeImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)

                    Text(order.storeName)
                        .font(.title2).bold()

                    Text("Ordered on \(order.orderDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)

                // Progress
                VStack(alignment: .leading, spacing: 12) {
                    Text(order.status)
                        .font(.headline)

                    ProgressView(value: order.progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                        .frame(height: 8)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                // Products
                VStack(spacing: 16) {
                    ForEach(order.items) { item in
                        HStack(spacing: 16) {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .background(Color.gray.opacity(0.1))

                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)

                                Text("Qty. \(item.quantity) • $\(String(format: "%.2f", item.price))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                    }
                }

                // Order Details
                VStack(alignment: .leading, spacing: 12) {
                    Text("Details")
                        .font(.headline)

                    HStack {
                        Text("Order Number")
                        Spacer()
                        Text(order.orderNumber)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Total")
                        Spacer()
                        Text("$\(String(format: "%.2f", order.total))")
                            .bold()
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Orders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    OrderDetailsView()
}

// Updated Model
struct OrderItemInfo: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let quantity: Int
    let price: Double
}

struct OrderModel {
    let storeName: String
    let storeImage: String
    let orderDate: String
    let status: String
    let progress: Double
    let items: [OrderItemInfo]
    let orderNumber: String
    let total: Double
}

let sampleOrder = OrderModel(
    storeName: "Pair Eyewear",
    storeImage: "pair", // Add "pair" image to Assets
    orderDate: "Friday",
    status: "On the Way",
    progress: 0.65,
    items: [
        OrderItemInfo(title: "The White - Kirby", imageName: "glasses1", quantity: 1, price: 25.00),
        OrderItemInfo(title: "Black Sun Top - Kirby", imageName: "glasses2", quantity: 1, price: 30.00)
    ],
    orderNumber: "542614",
    total: 55.00
)
