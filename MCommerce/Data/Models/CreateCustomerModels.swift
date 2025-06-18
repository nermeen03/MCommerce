//
//  CustomerModels.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//

import Foundation
struct CreateCustomerResponse: Decodable {
    let data: CreateCustomerData
}

struct CreateCustomerData: Decodable {
    let customerCreate: CustomerCreate?
}

struct CustomerCreate: Decodable {
    let customer: Customer?
    let customerUserErrors: [CustomerUserError]
}

struct Customer: Decodable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
}

struct CustomerUserError: Decodable {
    let field: [String]?
    let message: String
}
