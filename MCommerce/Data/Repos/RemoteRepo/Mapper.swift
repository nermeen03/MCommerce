//
//  Mapper.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

struct Mapper{
    static func mapToDiscountData(from response: DiscountNodesResponse) -> [DiscountData] {
        return response.data.discountNodes.edges.map { DiscountData(from: $0.node.discount) }
    }
//    static func mapToOrderData(from response: OrdersResponse) -> [OrderDataResponse]{
//        return response.data.orders.edges.map { item in
//            let data = item.node
//            let price = data.totalPriceSet.shopMoney.amount
//            let currencyCode = data.totalPriceSet.shopMoney.currencyCode
//            let createdAt = data.createdAt
//            let productImage = data.lineItems.edges.first?.node.variant?.product?.images.edges.first?.node.originalSrc
//            return OrderDataResponse(price: price, currencyCode: currencyCode, createdAt: createdAt, productImage: productImage)
//        }
//    }
    
    static func mapToDict(from address : AddressInfo) -> [String: Any] {
        return [
            "address1": address.address1,
            "address2": address.address2,
            "city": address.city,
            "country": address.country,
            "phone": address.phone,
            "type": address.type,
            "default": address.defaultAddress
        ]
    }
    
    static func mapToAddress(docId : String, from data : [String: Any]) -> AddressInfo{
        return AddressInfo(
            defaultAddress: data["default"] as? Bool ?? false,
            id: docId,
            address1: data["address1"] as! String,
            address2: data["address2"] as! String,
            city: data["city"] as! String,
            country: data["country"] as! String,
            phone: data["phone"] as! String,
            type: data["type"] as! String

        )
    }
    
//    static func CartItemToOrderItem(order : CartItem) -> OrderItem {
//        return OrderItem(
//            productId: order.id,
//            quantity: order.quantity ?? 1,
//            price: order.price,
//            variantId: order.variantId
//        )
//    }
    
    static func toAddress (address : AddressInfo) -> ShippingAddress{
        return ShippingAddress(address1: address.address1, address2: address.address2, city: address.city, country: address.country, phone: address.phone)
    }
}
