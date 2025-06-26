//
//  OrderModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

//struct OrdersResponse: Codable {
//    let data: OrdersData
//}
//
//struct OrdersData: Codable {
//    let orders: Orders
//}
//
//struct Orders: Codable {
//    let edges: [OrderEdge]
//}
//
//struct OrderEdge: Codable {
//    let node: OrderNode
//}
//
//struct OrderNode: Codable {
//    let id: String
//    let name: String
//    let createdAt: String
//    let totalPriceSet: MoneySet
//    let lineItems: LineItems
//}
//
//struct MoneySet: Codable {
//    let shopMoney: Money
//}
//
//struct Money: Codable {
//    let amount: String
//    let currencyCode: String
//}
//
//struct LineItems: Codable {
//    let edges: [LineItemEdge]
//}
//
//struct LineItemEdge: Codable {
//    let node: LineItemNode
//}
//
//struct LineItemNode: Codable {
//    let title: String
//    let quantity: Int
//    let variant: VariantTest?
//}
//
//struct VariantTest: Codable {
//    let image: ImageNodeTest?
//    let product: ProductTest?
//}

struct ImageNodeTest: Codable {
    let originalSrc: String
    let altText: String?
}

struct ProductTest: Codable {
    let images: ProductImages
}
struct ProductImages: Codable {
    let edges: [ProductImageEdge]
}

struct ProductImageEdge: Codable {
    let node: ImageNodeTest
}


struct OrderCreateResponse: Decodable {
    let data: OrderCreateData?
}

struct OrderCreateData: Decodable {
    let orderCreate: OrderCreatePayload
}

struct OrderCreatePayload: Decodable {
    let userErrors: [ShopifyUserError]
    let order: ShopifyOrder?
}

struct ShopifyUserError: Decodable {
    let field: [String]?
    let message: String
}

struct ShopifyOrder: Decodable {
    let id: String
    let totalTaxSet: ShopifyTaxSet?
    let lineItems: ShopifyLineItemConnection
}

struct ShopifyTaxSet: Decodable {
    let shopMoney: ShopifyMoney
}

struct ShopifyMoney: Decodable {
    let amount: String
    let currencyCode: String
}

struct ShopifyLineItemConnection: Decodable {
    let nodes: [ShopifyLineItem]
}

struct ShopifyLineItem: Decodable {
    let id: String
    let title: String
    let quantity: Int
}


//
//  OrderModel.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 19/06/2025.
//

import Foundation

struct ShippingAddress: Codable {
    let address1: String
    let address2: String?
    let city: String
    let country: String
    let phone: String
}



struct DraftOrderResponse : Codable {
    let data : DraftOrdersResponse
}
struct DraftOrdersResponse: Codable {
    let draftOrders: DraftOrdersConnection
}

struct DraftOrdersConnection: Codable {
    let edges: [DraftOrderEdge]
}

struct DraftOrderEdge: Codable {
    let node: DraftOrderNode
}

struct DraftOrderNode: Codable {
    let id: String
}



struct DraftOrderQueryResponse: Codable {
    let data: DraftOrderData
}

struct DraftOrderData: Codable {
    let draftOrder: DraftOrder
}

struct DraftOrder: Codable {
    let id: String
    let name: String
    let email: String
    let status: String
    let tags: [String]?
    let createdAt: String
    let appliedDiscount: DiscountTest?
    let shippingAddress: ShippingAddress?
    let lineItems: LineItemConnection
    let subtotalPriceSet: PriceSet
    let totalPriceSet: PriceSet
    let customAttributes : CustomAttribute?
}

struct LineItemConnection: Codable {
    let edges: [LineItemEdge]
}

struct LineItemEdge: Codable {
    let node: LineItem
}

struct LineItem: Codable {
    let id: String
    let title: String
    let quantity: Int
    let customAttributes: [CustomAttribute]
    let appliedDiscount: DiscountTest?
    let originalUnitPriceSet: PriceSet
    let variant: Variant?
}

struct DiscountTest: Codable {
    let description : String?
    let value: String?
    let amount : String?
    let valueType : String?
    let title : String?
}

struct Variant: Codable {
    let id: String
    let title: String
    let sku: String?
}

struct CustomAttribute: Codable {
    let key: String
    let value: String
}

struct PriceSet: Codable {
    let shopMoney: Money
}

struct Money: Codable {
    let amount: String
    let currencyCode: String
}

struct DraftOrderCreateResponse: Codable {
    let data: DraftOrderCreateData
}

struct DraftOrderCreateData: Codable {
    let draftOrderCreate: DraftOrderCreate
}

struct DraftOrderCreate: Codable {
    let draftOrder: DraftOrderID
}

struct DraftOrderID: Codable {
    let id: String
}


// Model to decode the GraphQL response for Order Creation
struct OrderCreateResponses: Codable {
    let data: OrderCreateDatas
}

struct OrderCreateDatas: Codable {
    let orderCreate: OrderCreate
}

struct OrderCreate: Codable {
    let order: Order
}

struct Order: Codable {
    let id: String
    let email: String
    let orderNumber: String
    let statusUrl: String
}


struct DraftOrderCompleteResponse: Codable {
    let data: DraftOrderCompleteData
    let extensions: Extensions
}

struct DraftOrderCompleteData: Codable {
    let draftOrderComplete: DraftOrderComplete
}

struct DraftOrderComplete: Codable {
    let draftOrder: DraftOrders
}

struct DraftOrders: Codable {
    let id: String
    let order: Orders
}

struct Orders: Codable {
    let id: String
}

struct Extensions: Codable {
    let cost: Cost
}

struct Cost: Codable {
    let requestedQueryCost: Int
    let actualQueryCost: Int
    let throttleStatus: ThrottleStatus
}

struct ThrottleStatus: Codable {
    let maximumAvailable: Double
    let currentlyAvailable: Double
    let restoreRate: Double
}
