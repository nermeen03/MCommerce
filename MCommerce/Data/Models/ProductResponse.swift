//
//  ProductResponse.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//

struct GraphQLProductResponse: Decodable {
    let data: ProductDataa
}

struct ProductDataa: Decodable {
    let products: ProductEdgeWrapper
}

struct ProductEdgeWrapper: Decodable {
    let edges: [ProductEdgee]
}

struct ProductEdgee: Decodable {
    let node: ProductNodee
}

struct ProductNodee: Decodable {
    let id: String
    let title: String
    let description: String
    let vendor: String
    let images: ImageEdgeWrapper
    let variants: VariantEdgeWrapper
}

struct ImageEdgeWrapper: Decodable {
    let edges: [ImageEdgee]
}

struct ImageEdgee: Decodable {
    let node: ImageNodee
}

struct ImageNodee: Decodable {
    let url: String
}

struct VariantEdgeWrapper: Decodable {
    let edges: [VariantEdge]
}

struct VariantEdge: Decodable {
    let node: VariantNodee
}

struct VariantNodee: Decodable {
    let price: String
}
