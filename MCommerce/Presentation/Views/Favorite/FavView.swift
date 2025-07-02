//
//  FavView.swift
//  MCommerce
//
//  Created by Jailan Medhat on 20/06/2025.
//

import SwiftUI

struct FavView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var viewModel: FavoriteViewModel = DIContainer.shared.resolveFavoritesViewModel()
    @State var showAlert : Bool = false
    @State var indexToDelete : IndexSet?
    var body: some View {
        if(!viewModel.isLoggedIn){
            VStack{
              
                Text("You must login to see your favorites").font(.title2).bold().bold().foregroundColor(.gray)
            }.frame(maxWidth: .infinity, maxHeight: .infinity ).background(.white.opacity(0.7))
        }
        else {
            if(viewModel.isLoading){
                VStack{
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).scaleEffect(2)
                }.frame(maxWidth: .infinity, maxHeight: .infinity ).background(.white.opacity(0.7))
            }
            else{
                if viewModel.favorites.isEmpty {
                    VStack {
                              
                               LottieView(animationName: "tradia") 
                                   .frame(width: 200, height: 200)
                        Text("You have no favorites")
                            .font(.title).bold().foregroundColor(.gray)
                    
                           }.frame(maxWidth: .infinity, maxHeight: .infinity ).background(.white.opacity(0.7))
                }
                else{
                    VStack{
                        SearchBarView(searchText: $viewModel.searchText).padding()
                        List{
                            
                            ForEach(viewModel.filteredFavorites){
                                prod in
                                FavCard(product: prod).onTapGesture {
                                    coordinator.navigate(to: .productInfo(product: prod.id!))
                                }
                            }.onDelete(perform: { index in
                                showAlert = true
                                indexToDelete = index
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Are you sure?"), message: Text("You want to delete this item?"), primaryButton: .destructive(Text("Delete")) {
                                    delete(at: indexToDelete!)
                                }, secondaryButton: .cancel())
                            }
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    }.listStyle(.plain)
                }}// else
        }
        }
    func delete(at offsets : IndexSet){
        for index in offsets {
               viewModel.deleteProduct(id: viewModel.favorites[index].productId)
           }
        
    }
    
}

//#Preview {
//   // FavView()
//}
