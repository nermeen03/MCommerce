//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct DiscountRowView: View {
    @StateObject private var viewModel: DiscountViewModel

    init() {
        _viewModel = StateObject(wrappedValue: DIContainer.shared.discountViewModel)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.discounts) { discount in
                            DiscountCardView(discount: discount)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchDiscounts()
        }
    }
}


#Preview {
    DiscountRowView()
}
