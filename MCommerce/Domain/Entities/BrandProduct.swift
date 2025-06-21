//
//  BrandProduct.swift
//  MCommerce
//
//  Created by abram on 18/06/2025.
//
struct BrandProduct: Identifiable , Hashable {
    let id: String
    let title: String
    let description: String?
    let imageUrl: String
    let price: Double
    let brandName: String
    let productType: String
}


extension ProductResponse.ProductNode {
    func toDomain() -> BrandProduct {
        let imageUrl = images.edges.first?.node.originalSrc ?? ""
        let priceString = variants.edges.first?.node.price.amount ?? "0.0"
        let price = Double(priceString) ?? 0.0

        return BrandProduct(
            id: id,
            title: title,
            description: description ?? "",
            imageUrl: imageUrl,
            price: price,
            brandName: productType,
            productType: productType
        )
    }
}

