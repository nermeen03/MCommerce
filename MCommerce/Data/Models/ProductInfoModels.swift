//
//  ProductInfoModels.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import Foundation
struct ProductDto: Codable {
    let id: String
    let title: String
    let description: String
    let images: [String]
    let variants: [VariantDto]
}

struct VariantDto: Codable {
    let id: String
    let title: String
    let price: String
    let selectedOptions: [SelectedOptionDto]
}

struct SelectedOptionDto: Codable {
    let name: String
    let value: String
}
struct GetProductResponse: Codable {
    let data: ProductData
}

struct ProductData: Codable {
    let product: ProductNode?
}

struct ProductNode: Codable {
    let id: String
    let title: String
    let description: String
    let images: ImageConnection
    let variants: VariantConnection
}

struct ImageConnection: Codable {
    let nodes: [ImageNode]
}

struct ImageNode: Codable {
    let url: String
}

struct VariantConnection: Codable {
    let nodes: [VariantNode]
}

struct VariantNode: Codable {
    let id: String
    let title: String
    let price: Price
    let selectedOptions: [SelectedOptionDto]
}

struct Price: Codable {
    let amount: String
}
