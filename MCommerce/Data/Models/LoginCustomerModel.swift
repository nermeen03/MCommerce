//
//  LoginCustomerModel.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

struct LoginResponse: Decodable {
    let data: LoginData
}

struct LoginData: Decodable {
    let customerAccessTokenCreate: CustomerAccessTokenCreate
}

struct CustomerAccessTokenCreate: Decodable {
    let customerAccessToken: CustomerAccessToken?
    let userErrors: [UserError]
}

struct CustomerAccessToken: Decodable {
    let accessToken: String
    let expiresAt: String
}

struct UserError: Codable {
    let field: [String]?
    let message: String
}


//
struct GetCustomerResponse: Decodable {
    let data: GetCustomerData
}

struct GetCustomerData: Decodable {
    let customer: Customer?
}
