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

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Brands")
                    .font(.title3)
                    .bold()
                Spacer()
                Image(systemName: "ellipsis")
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.brands) { brand in
                        ProductCard(title: brand.title, imageUrl: brand.imageUrl)
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

struct ProductCard: View {
    var title: String
    var imageUrl: String?

    var body: some View {
        VStack(spacing: 8) {
            if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 80)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            }

            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: 140)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

//#Preview {
//    BrandsView(viewModel: viewModel)
//}
