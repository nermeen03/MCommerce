//
//  SubCategoryResponse.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

//struct SubCategoryResponse: Decodable {
//    struct DataContainer: Decodable {
//        let collections: CollectionConnection
//    }
//
//    struct CollectionConnection: Decodable {
//        let edges: [CollectionEdge]
//    }
//
//    struct CollectionEdge: Decodable {
//        let node: SubCategoryDTO
//    }
//
//    let data: DataContainer
//}
struct SubCategoryResponse: Decodable {
    struct DataContainer: Decodable {
        let products: ProductConnection
    }

    struct ProductConnection: Decodable {
        let edges: [ProductEdge]
    }

    struct ProductEdge: Decodable {
        let node: SubCategoryDTO
    }

    let data: DataContainer
}
