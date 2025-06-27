//
//  OrderDetailsView.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//

import SwiftUI

struct OrderDetailsView: View {
    let order: OrderDataResponse

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    if let firstImage = order.items.first?.imageURL, let url = URL(string: firstImage) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                    } else {
                        Image(systemName: "shippingbox")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                    }

                    Text("Ordered on \(order.dateFormatted)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)
                VStack(alignment: .leading, spacing: 12) {
                    Text(order.status)
                        .font(.headline)

                    ProgressView(value: order.status.lowercased() == "completed" ? 1.0 : 0.5)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(height: 8)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                VStack(spacing: 16) {
                    ForEach(order.items) { item in
                        HStack(spacing: 16) {
                            if let imageURL = item.imageURL, let url = URL(string: imageURL) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)

                                Text("Qty. \(item.quantity) • \(item.currencyCode) \(item.price)")
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
                        Text("\(order.currencyCode) \(order.total)")
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
    
    }
}
