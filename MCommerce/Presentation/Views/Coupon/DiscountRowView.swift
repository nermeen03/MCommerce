//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct DiscountRowView: View {
    @ObservedObject var viewModel: DiscountViewModel
    @Binding var currentIndex: Int
    let maxCount: Int
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.discounts.prefix(maxCount)) { discount in
                        DiscountCardView(discount: discount)
                            .tag(discount.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            }
        }
        .onAppear {
            viewModel.fetchDiscounts()
        }
    }
}
