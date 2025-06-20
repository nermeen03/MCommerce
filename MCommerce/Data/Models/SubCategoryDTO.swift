//
//  SubCategoryDTO.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import Foundation

struct SubCategoryDTO: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let handle: String

    func toDomain(parentTitle: String) -> SubCategory {
        return SubCategory(title: title, handle: handle, parentCategory: parentTitle)
    }
}
