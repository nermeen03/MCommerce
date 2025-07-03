//
//  WishListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI
import SwiftData

struct WishListView: View {
    @ObservedObject var favViewModel: ProfileFavouriteViewModel

    var body: some View {
        VStack {
            WishListTitle(favViewModel: favViewModel)

            if favViewModel.isLoading {
                ProgressView()
                    .padding(.top, 20)
            } else {
                if favViewModel.favouriteProducts.isEmpty {
                    Text("No WishLists")
                        .padding(.top, 20)
                } else {
                    ScrollView {
                        WishListItemsView(favViewModel: favViewModel)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
    }
}

struct WishListTitle : View{
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var favViewModel: ProfileFavouriteViewModel
    var body: some View {
        HStack {
            Text("My WishLists")
                .font(.headline)
            Spacer()
//            if favViewModel.favouriteProducts.count > 4 {
                Button("Read More", action: {
                    coordinator.navigate(to: .favorites)
                })
                    .font(.headline)
                    .foregroundStyle(Color.deepPurple)
//            }
        }
        .padding()
    }
}

struct WishListItemsView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var favViewModel: ProfileFavouriteViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(favViewModel.favouriteProducts.prefix(4)) { product in
                VStack(alignment: .leading, spacing: 6) {
                    if let url = URL(string: product.imageUrl) {
                        ImageView(url: url)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    Text(product.title)
                        .font(.subheadline)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .foregroundColor(.primary)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 4)
                }
                .frame(width: UIScreen.main.bounds.width / 2 - 24)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 3)
                .padding(.bottom, 4)
                .onTapGesture {
                    coordinator.navigate(to: .productInfo(product: product.productId))
                }
            }
        }
    }
}
