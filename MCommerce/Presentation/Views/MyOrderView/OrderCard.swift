//
//  OrderCard.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//

import SwiftUI

struct OrderListCard: View {
    let order: OrderDataResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                if let imageUrl = order.items.first?.imageURL, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 70, height: 70)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .cornerRadius(8)
                                .clipped()
                        case .failure:
                            Color.gray
                                .frame(width: 70, height: 70)
                                .cornerRadius(8)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Color.gray
                        .frame(width: 70, height: 70)
                        .cornerRadius(8)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(order.items.first?.title ?? "Item")
                        .font(.headline)
                        .foregroundColor(.black)

                    if let qty = order.items.first?.quantity {
                        Text("Qty: \(qty)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text(order.status)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(6)
                        .background(Capsule().stroke(Color.blue, lineWidth: 1))

                    Text("\(order.currencyCode) \(order.total)")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

//import SwiftUI
//
//struct OrderCard: View {
//    let order: OrderItem
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack(alignment: .top) {
//                Image(order.imageName)
//                    .resizable()
//                    .frame(width: 70, height: 70)
//                    .cornerRadius(8)
//                    .background(Color.gray.opacity(0.1))
//                
//                VStack(alignment: .leading, spacing: 6) {
//                    Text(order.title)
//                        .font(.headline)
//                        .foregroundColor(.black)
//                    
//                    Text("Color: \(order.color)")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    
//                    Text("Qty: \(order.quantity)")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                
//                Spacer()
//                
//                VStack(alignment: .trailing, spacing: 6) {
//                    Text(order.status)
//                        .font(.caption)
//                        .foregroundColor(.blue)
//                        .padding(6)
//                        .background(Capsule().stroke(Color.blue, lineWidth: 1))
//                    
//                    Text(String(format: "$ %.2f", order.price))
//                        .font(.headline)
//                        .foregroundColor(.black)
//                }
//            }
//            
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
//    }
//}


//#Preview {
//    OrderCard(order: <#OrderItem#>)
//}
