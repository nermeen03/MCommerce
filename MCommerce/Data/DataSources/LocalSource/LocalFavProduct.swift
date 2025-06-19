//
//  LocalFavProduct.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation
import SwiftData

@Model
class FavProductInfo : Identifiable {
    var id = UUID()
    var userId : String
    var productId : String
    var productImage : String?
    var productName : String
    init(userId: String, productId: String, productImage: String? = nil, productName: String) {
        self.userId = userId
        self.productId = productId
        self.productImage = productImage
        self.productName = productName
    }
}
