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

class LoginViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
  
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var showError: Bool = false
    private let useCase : LoginUseCase
    init(useCase : LoginUseCase){
        self.useCase = useCase
    }
    
    func validateEmail(_ value: String)  {
        let emailRegex = #"^\S+@\S+\.\S+$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
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
                            UserDefaultsManager.shared.saveUserId(customer.id)
                            UserDefaultsManager.shared.setLoggedIn(true)
                            
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

