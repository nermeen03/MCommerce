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
    private let isLoggedInKey = "IS_LOGGED_IN"
    private let currencyKey = "CURRENCY"
    
    private init() {}
    
  
    
    func saveUserId(_ id: String) {
        UserDefaults.standard.set(id, forKey: userIdKey)
    }
    
    func getUserId() -> String? {
        UserDefaults.standard.string(forKey: userIdKey)
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
    func clearAll() {
        UserDefaults.standard.removeObject(forKey: userIdKey)
        UserDefaults.standard.removeObject(forKey: isLoggedInKey)
        UserDefaults.standard.removeObject(forKey: currencyKey)
    }
}
