//
//  ExpandedFilter.swift
//  MCommerce
//
//  Created by Jailan Medhat on 22/06/2025.
//
import SwiftUI

struct ExpandedFilter: View {
    @Binding var isFilterExpanded: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isFilterExpanded.toggle()
            }
        }) {
            HStack {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .foregroundColor(.deepPurple)
                
                Image(systemName: isFilterExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.deepPurple)
            }
        }
    }
    
}
