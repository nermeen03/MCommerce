//
//  User.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

struct Test: Codable {
    let collects: [Collect]
}

struct Collect: Codable {
    let id: Int
    let collection_id: Int
    let product_id: Int
    let created_at: String
    let updated_at: String
    let position: Int
    let sort_value: String
}
