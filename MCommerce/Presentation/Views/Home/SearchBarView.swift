//
//  SearchBarView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct SearchBarView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search products", text: .constant(""))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    SearchBarView()
}
