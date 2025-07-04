//
//  RegisterViewModel 2.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

import Foundation
import SwiftUI

class LoginViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLogged: Bool = false
    @Published var errorMessage: String = "Try again \n "
    @EnvironmentObject var coordinator: AppCoordinator

    private let useCase : LoginUseCase
    init(useCase : LoginUseCase){
        self.useCase = useCase
    }
    
    func validateEmail(_ value: String)  {
      
        if value.isEmpty {
            emailError = "Email is required"
        }
        else{
            emailError = ""
        }

        
    }
 
   
      
    

    func validatePassword(_ value: String) {
        if value.isEmpty {
            passwordError = "Password is required"
        }

      
        else{
            passwordError = ""
        }

    }
 
    func login (){
        if emailError.isEmpty && passwordError.isEmpty {
            isLoading = true
            useCase.login(email: email, password: password) { (result) in
                switch result {
                case .success(let data):
                    print("Login Success \(data.accessToken)")
                    UserDefaultsManager.shared.setAccessToken(data.accessToken)
                    self.useCase.getUserId(accessToken: data.accessToken) { result in
                        switch result {
                        case .success(let user):
                            print("User ID: \(user.id)")
                            UserDefaultsManager.shared.saveUserId(user.id.trimmingCharacters(in: .whitespaces).filter { $0.isNumber })

                            FirebaseFirestoreHelper.shared.fetchBadgeCount {fetchedCount in
                                DispatchQueue.main.async {
                                    CartBadgeVM.shared.badgeCount = fetchedCount
                                }
                            }
                            
                            FirebaseFirestoreHelper.shared.getCardId { result in
                                if let result = result {
                                    UserDefaultsManager.shared.setCartId(result)
                                    print("Cart ID set: \(result)")
                                } else {
                                    print("No cart ID found")
                                }

                                UserDefaultsManager.shared.saveData(email: user.email, firstName: user.firstName, lastName: user.lastName)
                                UserDefaultsManager.shared.setLoggedIn(true)

                                DispatchQueue.main.async {
                                    self.isLogged = true
                                    self.isLoading = false
                                }
                            }

                        case .failure(let error):
                            print("Failed to get user ID: \(error)")
                            DispatchQueue.main.async {
                                self.showError = true
                            }
                        }
                    }
                  
                case .failure(let error):
                    print("Login Error \(error)")
                    switch error {
                    case .custom(message: let message):
                        DispatchQueue.main.async {
                            self.isLogged = false
                            self.isLoading = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.errorMessage = message + "\n Try again"
                                self.showError = true
                               }
                            
                        }
                       
                    default:
                        break
                     }
                }
            }
        }
    }
    
    
}


