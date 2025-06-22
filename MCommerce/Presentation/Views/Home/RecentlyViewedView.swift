//
//  RecentlyViewedView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct RecentlyViewedView: View {
    @Binding var products : [Product]
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("You Might Like")
                .font(.title3)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(products) { product in
                        ProductCard(title:  product.title  , imageUrl: product.imageUrl).onTapGesture {
                            coordinator.navigate(to: .productInfo(product: product.id))
                        }
                    }
                }
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

