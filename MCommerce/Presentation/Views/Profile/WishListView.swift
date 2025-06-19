//
//  WishListView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import SwiftUI
import SwiftData

struct WishListView: View {
    
    @Query var favProductsList: [FavProductInfo]
    @Environment(\.modelContext) var modelContext
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        if favProductsList.isEmpty {
            Text("No WishList Found")
        }else{
            HStack{
                Text("My WishLists").font(.headline)
                Spacer()
                if favProductsList.count > 4 {
                    Button("Read More", action: {
                        
                    }).font(.headline)
                }
            }.padding()
            
            LazyVGrid(columns: columns) {
                ForEach(favProductsList.prefix(4)) { product in
                    VStack(alignment: .leading, spacing: 8) {
                        if let urlString = product.productImage, let url = URL(string: urlString) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 120, height: 120)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipped()
                                        .cornerRadius(8)
                                case .failure:
                                    Color.gray.frame(width: 120, height: 120)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Color.gray.frame(width: 120, height: 120)
                                .cornerRadius(8)
                        }
                        
                        Text(product.productName)
                            .font(.headline)
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    WishListView()
}
