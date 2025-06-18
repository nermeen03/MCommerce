//
//  SwiftUIView.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

import SwiftUI

struct ShoeStoreHomeView: View {
    let brand: Brand
    @State private var shoes: [Shoe] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(brand.title)
                    .font(.system(size: 50, weight: .bold, design: .default))


                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(shoes) { shoe in
                        ShoeCard(shoe: shoe)
                    }
                }
            }
            .padding()
            .onAppear {
                fetchShoes(for: brand)
            }
        }
    }

// MARK: - Shoe Card View
struct ShoeCard: View {
    var shoe: Shoe

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: shoe.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(height: 120)
            .cornerRadius(12)

            Text(shoe.brand)
                .font(.caption)
                .foregroundColor(.gray)

            Text(shoe.name)
                .font(.headline)

            Text(shoe.description)
                .font(.caption2)
                .foregroundColor(.gray)

            HStack {
                Text("$\(String(format: "%.2f", shoe.price))")
                    .font(.headline)
                Spacer()
                Button {
                    // action for cart
                } label: {
                    Image(systemName: "cart")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Shoe Model
struct Shoe: Identifiable {
    let id = UUID()
    let brand: String
    let name: String
    let description: String
    let price: Double
    let imageUrl: String
}

// MARK: - Sample Data
let sampleShoes = [
    Shoe(brand: "Converse", name: "Chuck Taylor", description: "All Star CX Flyease Heel Pop Men's Sneakers - White", price: 285.99, imageUrl: "https://via.placeholder.com/150"),
    Shoe(brand: "Nike", name: "Air Jordan", description: "Men's Basketball Shoes - White/Citrus/Black", price: 294.99, imageUrl: "https://via.placeholder.com/150"),
    Shoe(brand: "Nike", name: "Air Max 270", description: "Running Shoes - White/Black", price: 209.99, imageUrl: "https://via.placeholder.com/150"),
    Shoe(brand: "Jordan", name: "Retro 5", description: "Classic Men's Basketball Shoes", price: 310.00, imageUrl: "https://via.placeholder.com/150")
]

#Preview {
    ShoeStoreHomeView()
}
