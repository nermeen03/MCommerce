//
//  Cart.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 21/06/2025.
//

struct CartCreateResponse: Codable {
    let data: CartCreateData?
}

struct CartCreateData: Codable {
    let cartCreate: CartCreateResult?
}

struct CartCreateResult: Codable {
    let cart: CartCreateInfo?
}

struct CartCreateInfo: Codable {
    let id: String
    let checkoutUrl: String
}


struct CartResponse: Codable {
    let data: CartData?
}

struct CartData: Codable {
    let cartLinesAdd: CartLinesAddResult?
}

struct CartLinesAddResult: Codable {
    let cart: Cart?
}


struct Cart: Codable {
    let id: String
    let checkoutUrl: String
    let totalQuantity: Int
    let lines: CartLinesConnection?
    let estimatedCost: EstimatedCost?
}

struct CartLinesConnection: Codable {
    let edges: [CartLineEdge]
}

struct CartLineEdge: Codable {
    let node: CartLine
}

struct CartLine: Codable {
    let id: String
    let quantity: Int
    let merchandise: ProductVariant
}
//
//struct ProductVariant: Codable {
//    let id: String
//    let title: String
//    let price: Price
//    let product: ProductInfo
//}

struct ProductInfo: Codable {
    let title: String
    let featuredImage: FeaturedImage?
}

struct FeaturedImage: Codable {
    let url: String
}

struct Price: Codable {
    let amount: String
    let currencyCode: String?
}

struct EstimatedCost: Codable {
    let totalAmount: Price
}



struct GetCartResponse: Codable {
    let data: GetCartData?
}

struct GetCartData: Codable {
    let cart: CartDetails?
}

struct CartDetails: Codable {
    let id: String?
    let totalQuantity: Int?
    let checkoutUrl: String?
    let lines: CartLines?
}

struct CartLines: Codable {
    let edges: [CartEdge]
}

struct CartEdge: Codable {
    let node: CartLineNode
}

struct CartLineNode: Codable {
    let id: String
    let quantity: Int
    let merchandise: ProductVariant
}

struct ProductVariant: Codable {
    let id: String
    let title: String
    let price: Price
    let product: ProductInfo
}

//struct ProductInfo: Codable {
//    let title: String
//    let featuredImage: ProductImage?
//}

struct ProductImage: Codable {
    let url: String
}

struct GetCartResponseID: Decodable {
    let data: GetCartDataID?
}

struct GetCartDataID: Decodable {
    let cart: CartLinesContainerID?
}

struct CartLinesContainerID: Decodable {
    let lines: CartLinesEdgesID?
}

struct CartLinesEdgesID: Decodable {
    let edges: [CartLineEdgeID]
}

struct CartLineEdgeID: Decodable {
    let node: CartLineNodeID
}

struct CartLineNodeID: Decodable {
    let id: String
    let merchandise: VariantIDOnly
}

struct VariantIDOnly: Decodable {
    let id: String
}


