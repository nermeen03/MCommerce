//
//  HotSalesView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//
import SwiftUI

struct BrandsView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    private let cardSize: CGFloat = 170
    private let horizontalSpacing: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Brands")
                    .font(.title3).bold()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: horizontalSpacing) {
                    ForEach(viewModel.brands) { brand in
                        BrandCard(brand: brand, size: cardSize)
                            .onTapGesture {
                                coordinator.navigate(to: .brand(brand: brand))
                            }
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
}
struct BrandCard: View {
    let brand: Brand
    let size: CGFloat

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: brand.imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                default:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(width: size, height: size)
            .background(Color(.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            Text(brand.title)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: size)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 3, y: 2)
    }
}
