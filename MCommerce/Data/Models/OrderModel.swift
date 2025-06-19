//
//  OrderModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

struct OrdersResponse: Codable {
    let data: OrdersData
}

struct OrdersData: Codable {
    let orders: Orders
}

struct Orders: Codable {
    let edges: [OrderEdge]
}

struct OrderEdge: Codable {
    let node: OrderNode
}

struct OrderNode: Codable {
    let id: String
    let name: String
    let createdAt: String
    let totalPriceSet: MoneySet
    let lineItems: LineItems
}

struct MoneySet: Codable {
    let shopMoney: Money
}

struct Money: Codable {
    let amount: String
    let currencyCode: String
}

struct LineItems: Codable {
    let edges: [LineItemEdge]
}

struct LineItemEdge: Codable {
    let node: LineItemNode
}

struct LineItemNode: Codable {
    let title: String
    let quantity: Int
    let variant: VariantTest?
}

struct VariantTest: Codable {
    let image: ImageNodeTest?
    let product: ProductTest?
}

struct ImageNodeTest: Codable {
    let originalSrc: String
    let altText: String?
}

struct ProductTest: Codable {
    let images: ProductImages
}
struct ProductImages: Codable {
    let edges: [ProductImageEdge]
}

struct ProductImageEdge: Codable {
    let node: ImageNodeTest
}
