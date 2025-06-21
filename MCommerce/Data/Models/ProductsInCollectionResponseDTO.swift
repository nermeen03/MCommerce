//
//  ProductsInCollectionResponseDTO.swift
//  MCommerce
//
//  Created by abram on 19/06/2025.
//

struct ProductsInCollectionResponseDTO: Decodable {
    let data: CollectionWrapper

    struct CollectionWrapper: Decodable {
        let collection: ProductList
    }

    struct ProductList: Decodable {
        let products: ProductEdges
    }

    struct ProductEdges: Decodable {
        let edges: [ProductEdge]
    }

    struct ProductEdge: Decodable {
        let node: ProductNode
    }

    struct ProductNode: Decodable {
        let id: String
        let title: String
        let description: String
        let vendor: String
        let images: ImageList
        let priceRange: PriceRange
    }

    struct ImageList: Decodable {
        let edges: [ImageEdge]
    }

    struct ImageEdge: Decodable {
        let node: ProductImage
    }

    struct ProductImage: Decodable {
        let originalSrc: String
    }

    struct PriceRange: Decodable {
        let minVariantPrice: Price
    }

    struct Price: Decodable {
        let amount: String
    }

    func toDomainList() -> [BrandProduct] {
        data.collection.products.edges.map { edge in
            BrandProduct(
                id: edge.node.id,
                title: edge.node.title,
                description: edge.node.description,
                imageUrl: edge.node.images.edges.first?.node.originalSrc ?? "",
                price: Double(edge.node.priceRange.minVariantPrice.amount) ?? 0.0,
                brandName: edge.node.vendor,
                productType: edge.node.vendor
            )
        }
    }
}
struct ProductResponse: Decodable {
    let data: DataContainer

    struct DataContainer: Decodable {
        let collectionByHandle: CollectionByHandle?
        let products: ProductConnection?
    }

    struct CollectionByHandle: Decodable {
        let title: String
        let products: ProductConnection
    }

    struct ProductConnection: Decodable {
        let edges: [ProductEdge]
    }

    struct ProductEdge: Decodable {
        let node: ProductNode
    }

    struct ProductNode: Decodable {
        let id: String
        let title: String
        let description: String
        let productType: String
        let images: ImageConnection
        let variants: VariantConnection
    }

    struct ImageConnection: Decodable {
        let edges: [ImageEdge]
    }

    struct ImageEdge: Decodable {
        let node: ImageNode
    }

    struct ImageNode: Decodable {
        let originalSrc: String
    }

    struct VariantConnection: Decodable {
        let edges: [VariantEdge]
    }

    struct VariantEdge: Decodable {
        let node: VariantNode
    }

    struct VariantNode: Decodable {
        let price: Price
    }

    struct Price: Decodable {
        let amount: String
        let currencyCode: String
    }
}
