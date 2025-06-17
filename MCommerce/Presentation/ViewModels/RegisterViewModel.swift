//
//  RegisterViewModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//
import Foundation

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
     
     
        
      else  if digitsOnly.count != 11 {
         
            phoneNumberError = "Phone number must be exactly 11 digits"
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
    
    
    
}
