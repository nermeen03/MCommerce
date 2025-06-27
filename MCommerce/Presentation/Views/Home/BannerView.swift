//
//  BannerView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct BannerView: View {
    @StateObject private var viewModel = DIContainer.shared.discountViewModel
    @State private var currentIndex = 0
    private let maxCount = 4

    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $currentIndex) {
                Image("staticCoupon")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .tag(0)

                ForEach(Array(viewModel.discounts.prefix(maxCount).enumerated()), id: \.offset) { index, discount in
                    DiscountCardView(discount: discount)
                        .tag(index + 1)
                }
            }
            .frame(height: 220)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                viewModel.fetchDiscounts()
            }

            HStack(spacing: 8) {
                ForEach(0..<(1 + min(viewModel.discounts.count, maxCount)), id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.pinkPurple : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}
