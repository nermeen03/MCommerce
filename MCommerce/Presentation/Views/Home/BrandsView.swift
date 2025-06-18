//
//  HotSalesView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct BrandsView: View {
    let items = [
        ("Macbook Air M1", "$ 29,999", "laptopcomputer"),
        ("Sony WH1000XM5", "$ 4,999", "headphones"),
        ("FreeBuds Huawei", "$ 1,999", "earpods")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Brands")
                    .font(.title3)
                    .bold()
                Spacer()
                Image(systemName: "ellipsis")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items, id: \.0) { item in
                        ProductCard(title: item.0, price: item.1, systemImage: item.2)
                    }
                }
            }
        }
    }
}

struct ProductCard: View {
    var title: String
    var price: String
    var systemImage: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)

            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Text(price)
                .font(.caption)
                .foregroundColor(.green)
        }
        .frame(width: 140)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    BrandsView()
}
