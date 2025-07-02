//
//  ProductHomeCard.swift
//  MCommerce
//
//  Created by abram on 27/06/2025.
//

import SwiftUI


struct ProductHomeCard: View {
    let imageUrl: String
    let title: String
    let price: String
    let backgroundColor: Color = Color.randomPastel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)



            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .lineLimit(2)
                .padding(.horizontal, 8)

            Text(price)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
        }
        .frame(width: 180, height: 200)
        .background(backgroundColor.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

extension Color {
    static func randomPastel() -> Color {
        return Color(
            red: Double.random(in: 0.9...1.0),
            green: Double.random(in: 0.9...1.0),
            blue: Double.random(in: 0.9...1.0)
        )
    }
}
