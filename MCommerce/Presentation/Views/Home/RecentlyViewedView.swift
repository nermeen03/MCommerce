//
//  RecentlyViewedView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct RecentlyViewedView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently viewed")
                .font(.title3)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray5))
                            .frame(width: 120, height: 120)
                    }
                }
            }
        }
    }
}

#Preview {
    RecentlyViewedView()
}
