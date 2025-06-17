//
//  CouponModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

struct DiscountNodesResponse: Codable {
    let data: DiscountNodesData
}

struct DiscountNodesData: Codable {
    let discountNodes: DiscountNodes
}

struct DiscountNodes: Codable {
    let edges: [DiscountEdge]
}

struct DiscountEdge: Codable, Identifiable{
    var id: String { node.id }
    let node: DiscountNode
}

struct DiscountNode: Codable {
    let id: String
    let discount: Discount
}

struct Discount: Codable {
    let title: String
    let status: String
    let startsAt: String?
    let endsAt: String?
    let summary: String?
    let codes: CodesContainer?
}

struct CodesContainer: Codable {
    let nodes: [CodeNode]
}

struct CodeNode: Codable {
    let code: String
}

