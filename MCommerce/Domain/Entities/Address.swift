//
//  Address.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
class AddressInfo: Identifiable, Equatable, Hashable {
    var defaultAddress: Bool = false
    var id: String
    var address1: String
    var address2: String
    var city: String
    var country: String
    var phone: String
    var type: String

    init(defaultAddress: Bool = false, id: String, address1: String, address2: String, city: String, country: String, phone: String, type: String) {
        self.defaultAddress = defaultAddress
        self.id = id
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.country = country
        self.phone = phone
        self.type = type
    }

    static func == (lhs: AddressInfo, rhs: AddressInfo) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

