//
//  Mapper.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

struct Mapper{
    static func mapToDiscountData(from response: DiscountNodesResponse) -> [DiscountData] {
        return response.data.discountNodes.edges.map { DiscountData(from: $0.node.discount) }
    }
}
