//
//  SidebarMenuView.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import SwiftUI

struct SidebarMenuView: View {
    let items: [String]
    @Binding var selected: String
    let onChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .foregroundColor(item == selected ? .blue : .black)
                    .bold(item == selected)
                    .onTapGesture {
                        selected = item
                        onChange(item)
                    }
            }
            Spacer()
        }
        .padding(.top, 40)
        .frame(width: 100)
        .background(Color(UIColor.systemGray6))
    }
}

//#Preview {
//    SidebarMenuView()
//}
