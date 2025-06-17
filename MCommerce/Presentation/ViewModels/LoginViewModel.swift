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
 
    
    
    
}
//
//  LoginViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

