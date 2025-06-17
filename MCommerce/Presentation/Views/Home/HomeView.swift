//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                SearchBarView()
                BannerView()
                HotSalesView()
                RecentlyViewedView()
            }
            .padding()
        }
//        .padding(.bottom, 60)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 50)
        }

    }
}

#Preview {
    HomeView()
}
