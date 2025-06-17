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

struct ProductTest: Codable {
    let data: ProductData
}

struct ProductData: Codable {
    let products: ProductEdges
}

struct ProductEdges: Codable {
    let edges: [ProductNode]
}

struct ProductNode: Codable {
    let node: ProductDetail
}

struct ProductDetail: Codable {
    let id: String
    let title: String
    let description: String
    let onlineStoreUrl: String?
    let priceRange: PriceRange
    let images: ImageEdges
}

struct PriceRange: Codable {
    let minVariantPrice: VariantPrice
}

struct VariantPrice: Codable {
    let amount: String
    let currencyCode: String
}

struct ImageEdges: Codable {
    let edges: [ImageNode]
}

struct ImageNode: Codable {
    let node: ImageURL
}

struct ImageURL: Codable {
    let url: String
}
