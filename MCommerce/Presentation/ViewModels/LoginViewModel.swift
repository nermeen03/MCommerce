//
//  RegisterViewModel 2.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//


//
//  RegisterViewModel.swift
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
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
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
            useCase.login(email: email, password: password) { (result) in
                switch result {
                case .success(let data):
                    print("Login Success \(data.accessToken)")
                    self.useCase.getUserId(accessToken: data.accessToken) { result in
                        switch result {
                        case .success(let customer):
                            print("User ID: \(customer.id)")
                            UserDefaultsManager.shared.saveUserId(customer.id.trimmingCharacters(in: .whitespaces).filter { $0.isNumber })
                            UserDefaultsManager.shared.setLoggedIn(true)
                            DispatchQueue.main.async {
                                self.isLoggedIn = true
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
                    DispatchQueue.main.async {
                        self.showError = true
                    }
                }
            }
        }
    }
    
    
}
//
//  LoginViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

