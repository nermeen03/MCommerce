//
//  RecentlyViewedView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct RecentlyViewedView: View {
    @Binding var products: [Product]
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        VStack(alignment: .leading) {
            Text("You Might Like")
                .font(.title3)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(products) { product in
                        ProductHomeCard(
                            imageUrl: product.imageUrl ?? "",
                            title: extractTextBetweenPipes(from: product.title),
                            price: CurrencyFormatter.format(amountInEGP: product.price)
//                            backgroundColor: Color.white
                        )
                        .onTapGesture {
                            coordinator.navigate(to: .productInfo(product: product.id))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func extractTextBetweenPipes(from title: String) -> String {
        let parts = title.split(separator: "|", omittingEmptySubsequences: false)
        if parts.count >= 3 {
            return parts[1].trimmingCharacters(in: .whitespaces)
        } else {
            return title
        }
    }
}
