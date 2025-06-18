//
//  SubCategoryTabsView.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import SwiftUI

struct SubCategoryTabsView: View {
    let subCategories: [String]
    @Binding var selected: String

    var body: some View {
        HStack {
            ForEach(subCategories, id: \.self) { sub in
                Text(sub)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(selected == sub ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        selected = sub
                    }
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    SubCategoryTabsView()
//}
