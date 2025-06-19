//
//  CategoryTabsView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct CategoryTabsView: View {
    let categories = ["Technology", "Fashion", "Sports", "Supermarket"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                }
            }
        }
    }
}


#Preview {
    CategoryTabsView()
}
