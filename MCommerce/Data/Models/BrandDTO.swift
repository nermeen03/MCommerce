//
//  BrandDTO.swift
//  MCommerce
//
//  Created by abram on 17/06/2025.
//

struct BrandsResponse: Decodable {
    let data: BrandsData
}

struct BrandsData: Decodable {
    let collections: CollectionsConnection
}

struct CollectionsConnection: Decodable {
    let edges: [CollectionEdge]
}

struct CollectionEdge: Decodable {
    let node: BrandDTO
}

struct BrandDTO: Decodable {
    let id: String
    let title: String
    let image: ImageDTO?
}

struct ImageDTO: Decodable {
    let url: String
}

