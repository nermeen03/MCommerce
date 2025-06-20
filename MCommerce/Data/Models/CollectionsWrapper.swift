//
//  CollectionsWrapper.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//
struct CollectionResponse: Decodable {
    let data: DataContainer

    struct DataContainer: Decodable {
        let collections: CollectionList

        struct CollectionList: Decodable {
            let edges: [Edge]

            struct Edge: Decodable {
                let node: TitleNode

                struct TitleNode: Decodable {
                    let title: String
                    let handle: String
                }
            }
        }
    }
}

