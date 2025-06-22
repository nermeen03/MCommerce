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
    let id: String?
    let price: Price

    enum CodingKeys: String, CodingKey {
        case id
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)

        // Try decoding `price` as nested object first
        if let priceObject = try? container.decode(Price.self, forKey: .price) {
            price = priceObject
        } else {
            // If it's a plain string
            let priceString = try container.decode(String.self, forKey: .price)
            price = Price(amount: priceString, currencyCode: nil)
        }
    }
}




