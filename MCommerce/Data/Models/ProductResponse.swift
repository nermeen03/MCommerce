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
    let edges: [ProductEdge]
}

struct ProductEdge: Decodable {
    let node: ProductNode
}

struct ProductNode: Decodable {
    let id: String
    let title: String
    let description: String
    let vendor: String
    let images: ImageEdgeWrapper
    let variants: VariantEdgeWrapper
}

struct ImageEdgeWrapper: Decodable {
    let edges: [ImageEdge]
}

struct ImageEdge: Decodable {
    let node: ImageNode
}

struct ImageNode: Decodable {
    let url: String
}

struct VariantEdgeWrapper: Decodable {
    let edges: [VariantEdge]
}

struct VariantEdge: Decodable {
    let node: VariantNode
}

struct VariantNode: Decodable {
    let price: String
}
