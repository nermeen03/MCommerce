//
//  SubCategory.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import Foundation

struct SubCategory: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let handle: String
    let parentCategory: String
}
