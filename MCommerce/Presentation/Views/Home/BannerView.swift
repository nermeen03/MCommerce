//
//  BannerView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct BannerView: View {
    let banners = ["banner", "banner", "banner"]
    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $currentIndex) {
                ForEach(0..<banners.count, id: \.self) { index in
                    Image(banners[index])
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(12)
                        .tag(index)
                        .padding(.horizontal, 16)
                }
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            HStack(spacing: 8) {
                ForEach(0..<banners.count, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.orange : Color.gray.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}


#Preview {
    BannerView()
}
