//
//  SearchBarView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search products", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
//
//#Preview {
//    SearchBarView()
//}
