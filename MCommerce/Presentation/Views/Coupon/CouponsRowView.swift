//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct CouponsRowView: View {
    @StateObject private var viewModel = DiscountViewModel()

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
                            CouponCardView(discount: discount)
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
    CouponsRowView()
}
