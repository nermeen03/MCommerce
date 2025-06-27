//
//  ProfileViewModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 20/06/2025.
//

import Foundation

class ProfileViewModel{
    let favViewModel : ProfileFavouriteViewModel
    let orderViewModel : ProfileOrderViewModel
    var isLogged : Bool
    
    init(favViewModel: ProfileFavouriteViewModel, orderViewModel: ProfileOrderViewModel) {
        self.favViewModel = favViewModel
        self.orderViewModel = orderViewModel
        self.isLogged = UserDefaultsManager.shared.isLoggedIn()
    }

    func getData() {
        if !isLogged {
            orderViewModel.isLoading = false
            favViewModel.isLoading = false
        }else{
            favViewModel.getFavouriteProducts()
            orderViewModel.getOrder()}
    }
    
}

class ProfileOrderViewModel : ObservableObject{
    private var getOrderUseCase : getOrderUseCase
    @Published var orders : [OrderDataResponse] = []
    @Published var isLoading : Bool = false
    
    init(getOrderUseCase: getOrderUseCase) {
        self.getOrderUseCase = getOrderUseCase
    }
    
    func getOrder(){
//        orders.removeAll()
        isLoading = true
        getOrderUseCase.getOrders(completion: {[weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let orders):
                self?.orders = orders
            case .failure(let error):
                self?.orders = []
                print("Error : \(error)")
            }
        })
    }
    
}

class ProfileFavouriteViewModel : ObservableObject{
    
    private var getFavUseCase : GetFavProdUseCase
    @Published var favouriteProducts : [FavoriteProduct] = []
    @Published var isLoading : Bool = false
    
    init(getFavUseCase: GetFavProdUseCase) {
        self.getFavUseCase = getFavUseCase
    }
    
    func getFavouriteProducts() {
        self.isLoading = true
        getFavUseCase.execute(completion: {[weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let favProducts):
                self?.favouriteProducts = favProducts
            case .failure(let error):
                self?.favouriteProducts = []
                print("Error : \(error)")
            }
        })
    }
}
