//
//  HotSalesView.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//
import SwiftUI

// MARK: - BrandsView
struct BrandsView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    // Card width/height in one place so it’s easy to tweak
    private let cardSize: CGFloat = 160
    private let horizontalSpacing: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Header ----------------------------------------------------------
            HStack {
                Text("Brands")
                    .font(.title3).bold()
                Spacer()
                Image(systemName: "ellipsis")
                    .foregroundStyle(.secondary)
            }

            // Horizontal list -------------------------------------------------
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: horizontalSpacing) {
                    ForEach(viewModel.brands) { brand in
                        BrandCard(brand: brand, size: cardSize)
                            .onTapGesture {
                                coordinator.navigate(to: .brand(brand: brand))
                            }
                    }
                }
                .padding(.horizontal, horizontalSpacing)   // one unified padding
            }
        }
        .padding(.horizontal) // outer padding for the whole section
    }
}

// MARK: - BrandCard
struct BrandCard: View {
    let brand: Brand        // Assumes Brand conforms to Identifiable
    let size: CGFloat       // Square size for both image & card width

    var body: some View {
        VStack(spacing: 8) {

            // Thumbnail ------------------------------------------------------
            AsyncImage(url: URL(string: brand.imageUrl ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit() // keeps aspect, centres automatically
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

            // Title ----------------------------------------------------------
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

//struct BrandsView: View {
//    @StateObject var viewModel: HomeViewModel
//    @EnvironmentObject var coordinator: AppCoordinator
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text("Brands")
//                    .font(.title3)
//                    .bold()
//                Spacer()
//                Image(systemName: "ellipsis")
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(viewModel.brands) { brand in
//                        ProductCard(title: brand.title, imageUrl: brand.imageUrl)
//                            .onTapGesture {
//                                coordinator.navigate(to: .brand(brand: brand))
//                            }
//                    }
//                }
//            }
//        }
//        .padding(.horizontal)
//    }
//}
//
//struct ProductCard: View {
//    var title: String
//    var imageUrl: String?
//
//    var body: some View {
//        VStack(spacing: 8) {
//            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image.resizable().scaledToFit()
//                    case .failure:
//                        Image(systemName: "photo")
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//                .frame(height: 80)
//                .background(Color(.systemGray5))
//                .cornerRadius(10)
//            } else {
//                Image(systemName: "photo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 80)
//                    .padding()
//                    .background(Color(.systemGray5))
//                    .cornerRadius(10)
//            }
//
//            Text(title)
//                .font(.subheadline)
//                .multilineTextAlignment(.center)
//                .lineLimit(1)
//        }
//        .frame(width: 140)
//        .padding(.horizontal)
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(radius: 2)
//    }
//}

//#Preview {
//    BrandsView(viewModel: viewModel)
//}
