//
//  User.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

struct ProductTest: Codable {
    let data: ProductData
}

struct ProductData: Codable {
    let products: ProductTestEdges
}

struct ProductTestEdges: Codable {
    let edges: [ProductTestNode]
}

struct ProductTestNode: Codable {
    let node: ProductDetail
}

struct ProductDetail: Codable {
    let id: String
    let title: String
    let description: String
    let onlineStoreUrl: String?
    let priceRange: PriceRange
    let images: ProductImageEdges
}

struct PriceRange: Codable {
    let minVariantPrice: VariantPrice
}

struct VariantPrice: Codable {
    let amount: String
    let currencyCode: String
}

struct ProductImageEdges: Codable {
    let edges: [ProductImageNode]
}

struct ProductImageNode: Codable {
    let node: ProductImageURL
}

struct ProductImageURL: Codable {
    let url: String
}
