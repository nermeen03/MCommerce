//
//  UserDefault.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userIdKey = "USER_ID"
    private let userNameKey = "USER_Name"
    private let isLoggedInKey = "IS_LOGGED_IN"
    private let currencyKey = "CURRENCY"
    private let emailKey = "EMAIL"
    private let firstNameKey = "FIRST_NAME"
    private let lastNameKey = "LAST_NAME"
    private let phoneNumberKey = "PHONE_NUMBER"
    
    private init() {}
    
  
    
    func saveUserId(_ id: String) {
        UserDefaults.standard.set(id, forKey: userIdKey)
    }
    
    func getUserId() -> String? {
        UserDefaults.standard.string(forKey: userIdKey)
    }
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
    }
    
    func getUserName() -> String? {
        UserDefaults.standard.string(forKey: userNameKey)
    }
    
    func clearUserId() {
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
    
    func saveCurrency(_ currency: String) {
        UserDefaults.standard.set(currency, forKey: currencyKey)
    }
    
    func getCurrency() -> String? {
        UserDefaults.standard.string(forKey: currencyKey)
    }
    
    func setLoggedIn(_ loggedIn: Bool) {
        UserDefaults.standard.set(loggedIn, forKey: isLoggedInKey)
    }
    
    func isLoggedIn() -> Bool {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    func logout() {
        clearUserId()
        setLoggedIn(false)
    }
    func saveData(email : String , firstName : String , lastName : String){
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(firstName, forKey: firstNameKey)
        UserDefaults.standard.set(lastName, forKey: lastNameKey)
       
        
    }
  func getEmail() -> String? {
        UserDefaults.standard.string(forKey: emailKey)
    }
    func getFirstName() -> String? {
        UserDefaults.standard.string(forKey: firstNameKey)
    }
    func getLastName() -> String? {
        UserDefaults.standard.string(forKey: lastNameKey)
    }
    func clearAll() {
        UserDefaults.standard.removeObject(forKey: userIdKey)
        UserDefaults.standard.removeObject(forKey: isLoggedInKey)
        UserDefaults.standard.removeObject(forKey: currencyKey)
    }
}
