//
//  RegisterViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//
import Foundation
import SwiftUI

class RegisterViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name : String = ""
    @Published var phoneNumber : String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPasswordError: String = ""
    @Published var nameError : String = ""
    @Published var phoneNumberError : String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = "Try again \n "

    @EnvironmentObject var coordinator: AppCoordinator

   // @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    private let useCase: RegisterUseCase
    
    init(registerUseCase: RegisterUseCase) {
        self.useCase = registerUseCase
    }
    func validateEmail(_ value: String)  {
        let emailRegex = #"^\S+@\S+\.\S+$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if value.isEmpty {
            emailError = "Email is required"
        }


       else if !predicate.evaluate(with: value) {
            emailError = "Invalid email format"
        }
        else{
            emailError = ""
        }

        
    }
    func validatePhoneNumber(_ value: String) {
        let digitsOnly = value.trimmingCharacters(in: .whitespaces).filter { $0.isNumber }
        if value.isEmpty {
           phoneNumberError = "Phone number is required"
        }
     
     
        
      else  if digitsOnly.count < 11 {
         
            phoneNumberError = "Phone number must be  11 digits"
        }
        else {
            phoneNumberError = ""
        }
        

      
    }
    func validateName(_ value: String)  {
        if value.isEmpty {
            nameError = "Name is required"
        }
        else {
            nameError = ""
        }
        
      
    }

    func validatePassword(_ value: String) {
        if value.isEmpty {
            passwordError = "Password is required"
        }

      else  if value.count < 6 {
            passwordError = "Password must be at least 6 characters"
        }
        else{
            passwordError = ""
        }

    }
    func validateConfirmPassword(_ value: String) {
        if value.isEmpty {
            confirmPasswordError = "Confirm password is required"
        }
        
      else  if value != self.password {
            confirmPasswordError = "Passwords do not match"
        }
        else {
            confirmPasswordError = ""
        }
        
      
    }
    
    func validateAllFields() -> Bool {
        return self.nameError.isEmpty && self.phoneNumberError.isEmpty && self.passwordError.isEmpty && self.confirmPasswordError.isEmpty && self.email.isEmpty
    }
    func getFirstPart(beforeSpace text: String) -> String? {
        guard let range = text.range(of: " ") else { return nil }
        return String(text[..<range.lowerBound])
    }
    func getSecondPart(afterSpace text: String) -> String? {
        guard let range = text.range(of: " ") else { return nil }
        return String(text[range.upperBound...])
    }
    func generatePhoneNumber(from phone: String) -> String {
        guard !phone.isEmpty else { return "" }
        return "+2" + phone
    }
    func register () {
        if !self.validateAllFields() {
            isLoading = true
            useCase.register(user: User(email: email, firstName: getFirstPart(beforeSpace: name) ?? name, lastName: getSecondPart(afterSpace: name) ??  name, password:  password, phoneNumber: generatePhoneNumber(from: phoneNumber))){
                result in switch result {
                case .success(let user):
                    print("User registered successfully: \(user.id)")
                    UserDefaultsManager.shared.saveUserId(user.id)
                    UserDefaultsManager.shared.setLoggedIn(true)
                    UserDefaultsManager.shared.saveData(email: user.email, firstName: user.firstName, lastName: user.lastName)
                    DispatchQueue.main.async {
                        self.isRegistered = true
                        self.isLoading = false
                        self.coordinator.navigate(to: .home)
                 
                    }
                case .failure(let error):
                   switch error {
                   case .custom(message: let message):
                       DispatchQueue.main.async {
                           self.isRegistered = false
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
