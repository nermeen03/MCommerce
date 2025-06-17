//
//  User.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

struct User {
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    var phoneNumber: String
    init(email: String, firstName: String, lastName: String, password: String, phoneNumber: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.phoneNumber = phoneNumber
    }
}
