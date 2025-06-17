//
//  Discount.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import Foundation

struct DiscountData : Identifiable {
    let id = UUID()
    let title: String
    let status: String
    let startsAt: String?
    let endsAt: String?
    let summary: String?
    let codes: [String]?
    init(from discount: Discount) {
        self.title = discount.title
        self.status = discount.status
        self.startsAt = discount.startsAt
        self.endsAt = discount.endsAt
        self.summary = discount.summary
        self.codes = discount.codes?.nodes.map { $0.code }
    }
}
