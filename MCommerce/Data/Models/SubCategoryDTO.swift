//
//  SubCategoryDTO.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

import Foundation

struct SubCategoryDTO: Decodable, Identifiable {
    let id: String
    let title: String
    let handle: String
    let productType: String

    func toDomain(parentTitle: String) -> SubCategory {
        return SubCategory(title: productType, handle: handle, parentCategory: parentTitle)
    }
}

struct SubProductResponse: Decodable {
    let data: DataContainer

    struct DataContainer: Decodable {
        let products: ProductConnection
    }

    struct ProductConnection: Decodable {
        let edges: [ProductEdge]
    }

    struct ProductEdge: Decodable {
        let node: SubProductDTO
    }
}

struct SubProductDTO: Decodable {
    let id: String
    let title: String
    let handle: String
    let productType: String

    func toDomain() -> BrandProduct {
        return BrandProduct(
            id: id,
            title: title,
            description: "",
            imageUrl: "",
            price: 0.0,
            brandName: "",
            productType: ""
        )
    }

    func toSubCategory(parentTitle: String) -> SubCategory {
        return SubCategory(title: productType, handle: handle, parentCategory: parentTitle)
    }
}
