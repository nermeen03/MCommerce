//
//  Address.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
struct AddressInfo : Identifiable, Equatable, Hashable{
    var defaultAddress: Bool = false
    let id : String
    let address1: String?
    let address2: String?
    let city: String?
    let zip: String?
    let country: String?
    let phone: String?
    let name : String?
    let type : String
}
