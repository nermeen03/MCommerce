//
//  ImageView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import SwiftUI

struct ImageView: View {
    let url : URL
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 120)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
            case .failure:
                Color.gray.frame(height: 120)
                    .cornerRadius(8)
            @unknown default:
                EmptyView()
            }
        }
    }
}
