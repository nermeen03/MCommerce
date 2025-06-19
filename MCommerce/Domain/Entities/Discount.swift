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
    let percentage : String
    init(from discount: Discount) {
        self.title = discount.title
        self.status = discount.status
        self.startsAt = discount.startsAt
        self.endsAt = formatDate(discount.endsAt ?? "")
        self.summary = discount.summary
        self.codes = discount.codes?.nodes.map { $0.code }
        if let percentage = discount.customerGets?.value.percentage {
            self.percentage = "\(Int(percentage * 100))%"
        } else {
            self.percentage = ""
        }

    }
}
func formatDate(_ isoDateString: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime]

    if let date = isoFormatter.date(from: isoDateString) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: date)
    } else {
        return isoDateString
    }
}
