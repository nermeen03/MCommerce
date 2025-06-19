//
//  Test.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 18/06/2025.
//

import Foundation
import SwiftUI

class OrderViewModel : ObservableObject{
    @Published var ordersArray : [OrderDataTest] = []
    @Published var isLoading = true

    func getOrders(){
        ordersArray.removeAll()
        
        getOrderTest { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):

                    self.ordersArray = response.data.orders.edges.map { item in
                        let data = item.node
                        let price = data.totalPriceSet.shopMoney.amount
                        let currencyCode = data.totalPriceSet.shopMoney.currencyCode
                        let createdAt = data.createdAt
                        let productImage = data.lineItems.edges.first?.node.variant?.product?.images.edges.first?.node.originalSrc
                        return OrderDataTest(price: price, currencyCode: currencyCode, createdAt: createdAt, productImage: productImage)
                    }
                case .failure(let error):
                    print("Error fetching orders: \(error)")
                }
            }
        }
    }
}
    
func getOrderTest(completion : @escaping (Result<OrdersResponse, NetworkError>) -> Void){
    let query = """
        {
          orders(first: 5) {
            edges {
              node {
                id
                name
                createdAt
                totalPriceSet {
                  shopMoney {
                    amount
                    currencyCode
                  }
                }
                lineItems(first: 5) {
                  edges {
                    node {
                      title
                      quantity
                      variant {
                        id
                        image {
                          originalSrc
                        }
                        product {
                          images(first: 1) {
                            edges {
                              node {
                                originalSrc
                                altText
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }

        """
    ApiCalling().callQueryApi(query: query,useToken: true ,completion: {(result : Result<OrdersResponse, NetworkError>) in
        completion(result)
    })
    
    
}

struct OrderDataTest : Identifiable{
    let id = UUID()
    var price : String
    var currencyCode : String
    var createdAt : String
    var productImage : String?
}

struct OrdersResponse: Codable {
    let data: OrdersData
}

struct OrdersData: Codable {
    let orders: Orders
}

struct Orders: Codable {
    let edges: [OrderEdge]
}

struct OrderEdge: Codable {
    let node: OrderNode
}

struct OrderNode: Codable {
    let id: String
    let name: String
    let createdAt: String
    let totalPriceSet: MoneySet
    let lineItems: LineItems
}

struct MoneySet: Codable {
    let shopMoney: Money
}

struct Money: Codable {
    let amount: String
    let currencyCode: String
}

struct LineItems: Codable {
    let edges: [LineItemEdge]
}

struct LineItemEdge: Codable {
    let node: LineItemNode
}

struct LineItemNode: Codable {
    let title: String
    let quantity: Int
    let variant: VariantTest?
}

struct VariantTest: Codable {
    let image: ImageNodeTest?
    let product: ProductTest?
}

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



import SwiftData

@Model
class FavProductInfo : Identifiable {
    var id = UUID()
    var userId : String
    var productId : String
    var productImage : String?
    var productName : String
    init(userId: String, productId: String, productImage: String? = nil, productName: String) {
        self.userId = userId
        self.productId = productId
        self.productImage = productImage
        self.productName = productName
    }
}

struct CreateAddressResponse: Decodable {
    let data: CustomerAddressCreateData?
    let errors: [GraphQLError]?
}

struct CustomerAddressCreateData: Decodable {
    let customerAddressCreate: CustomerAddressCreateResult?
}

struct CustomerAddressCreateResult: Decodable {
    let customerAddress: CustomerAddressValue?
    let userErrors: [UserError]?
}

struct CustomerAddressValue: Decodable {
    let id: String
    let address1: String?
    let address2: String?
    let city: String?
    let country: String?
    let zip: String?
    let phone: String?
    let province: String?
}


struct GraphQLError: Decodable {
    let message: String
}

func createCustomerAddress(customerAccessToken: String, address: [String: Any], completion: @escaping (Result<CustomerAddress, NetworkError>) -> Void) {
    
    let mutation = """
    mutation customerAddressCreate($customerAccessToken: String!, $address: MailingAddressInput!) {
      customerAddressCreate(customerAccessToken: $customerAccessToken, address: $address) {
        customerAddress {
          id
          address1
          address2
          city
          country
          zip
          phone
          province
        }
        userErrors {
          field
          message
        }
      }
    }
    """

    let variables: [String: Any] = [
        "customerAccessToken": customerAccessToken,
        "address": address
    ]

    let body: [String: Any] = [
        "query": mutation,
        "variables": variables
    ]

    ApiCalling().callQueryApi(query: mutation,variables: variables ,completion: {(result : Result<CreateAddressResponse,NetworkError>) in print(result)})
}


struct AddressInfo {
    var defaultAddress: Bool
    let id: String
    let address1: String?
    let address2: String?
    let city: String?
    let province: String?
    let zip: String?
    let country: String?
    let phone: String?
}



class SettingsViewModel : ObservableObject{
    @Published var addressArray : [AddressInfo] = []
    @Published var isLoading = true
    let customerId : String = "TestId"
    
    func createAddress(address: AddressInfo, customerAccessToken: String) {
        let mutation = """
        mutation customerAddressCreate($customerAccessToken: String!, $address: MailingAddressInput!) {
          customerAddressCreate(customerAccessToken: $customerAccessToken, address: $address) {
            customerAddress {
                id
                address1
                address2
                city
                country
                zip
                phone
                province
            }
            userErrors {
              field
              message
            }
          }
        }
        """

        let addressInput: [String: Any] = [
            "address1": address.address1 ?? "",
            "address2": address.address2 ?? "",
            "city": address.city ?? "",
            "province": address.province ?? "",
            "zip": address.zip ?? "",
            "country": address.country ?? "",
            "phone": address.phone ?? ""
        ]

        let variables: [String: Any] = [
            "customerAccessToken": customerAccessToken,
            "address": addressInput
        ]

        ApiCalling().callQueryApi(query: mutation, variables: variables, useToken: true) { (result: Result<GraphQLResponse<CustomerAddressCreateResponse>, NetworkError>) in
            switch result {
            case .success(let response):
                if let userErrors = response.data.customerAddressCreate?.userErrors, !userErrors.isEmpty {
                    print("❗️ User Errors:", userErrors)
                    return
                }
                guard let addressId = response.data.customerAddressCreate?.customerAddress?.id else {
                    print("❗️ Address creation failed, no ID returned.")
                    return
                }
                print("✅ Address Created ID: \(addressId)")

                if address.defaultAddress {
                    self.updateDefaultAddress(customerId: customerAccessToken, addressId: addressId)
                }

            case .failure(let error):
                print("❗️ Error creating address:", error)
            }
        }
    }

    func updateDefaultAddress(customerId: String, addressId: String) {
        let mutation = """
            mutation customerDefaultAddressUpdate($customerId: ID!, $addressId: ID!) {
              customerDefaultAddressUpdate(customerId: $customerId, addressId: $addressId) {
                customer {
                  defaultAddress {
                    id
                  }
                }
                userErrors {
                  field
                  message
                }
              }
            }
        """

        let variables: [String: Any] = [
            "customerId": customerId,
            "addressId": addressId
        ]

        let body: [String: Any] = [
            "query": mutation,
            "variables": variables
        ]

        ApiCalling().callQueryApi(query: mutation, variables: body, useToken: true) { (result: Result<GraphQLResponse<CustomerDefaultAddressUpdateResponse>, NetworkError>) in
            switch result {
            case .success(let response):
                if let userErrors = response.data.customerDefaultAddressUpdate.userErrors, !userErrors.isEmpty {
                    print("❗️ Default Address Errors:", userErrors)
                } else {
                    print("✅ Default Address Updated Successfully.")
                }
            case .failure(let error):
                print("❗️ Error updating default address:", error)
            }
        }
    }


    
//    func getAddresses(){
//        getUserAddress(customerId: customerId, completion: { result in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let response):
//                    let customer = response.data.customer
//                    if customer?.defaultAddress != nil{
//                        var data = customer?.defaultAddress
//                        let id = data?.id
//                        let address1 = data?.address1
//                        let address2 = data?.address2
//                        let city = data?.city
//                        let province = data?.province
//                        let zip = data?.zip
//                        let country = data?.country
//                        let phone = data?.phone
//                        self.addressArray.append(AddressInfo(defaultAddress: true, id: id ?? "", address1: address1, address2: address2, city: city, province: province, zip: zip, country: country, phone: phone))
//                    }
//                    let addresses = customer?.addresses?.edges ?? []
//                    for address in addresses {
//                        let data = address.node
//                        let id = data.id
//                        let address1 = data.address1
//                        let address2 = data.address2
//                        let city = data.city
//                        let province = data.province
//                        let zip = data.zip
//                        let country = data.country
//                        let phone = data.phone
//                        self.addressArray.append(AddressInfo(defaultAddress: false, id: id, address1: address1, address2: address2, city: city, province: province, zip: zip, country: country, phone: phone))
//                    }
//                case .failure(let error):
//                    print("Error fetching orders: \(error)")
//                
//                }
//            }
//        })
//    }
    
//    func getUserAddress(customerId : String, completion : @escaping (Result<CustomerAddressesResponse,NetworkError>)->Void){
//        let query = """
//        query getCustomerAddresses($customerAccessToken: String!) {
//          customer(customerAccessToken: $customerAccessToken) {
//              firstName
//              lastName
//              email
//              defaultAddress {
//                id
//                address1
//                address2
//                city
//                province
//                zip
//                country
//                phone
//              }
//              addresses(first: 10) {
//                edges {
//                  node {
//                    id
//                    address1
//                    address2
//                    city
//                    province
//                    zip
//                    country
//                    phone
//                  }
//                }
//              }
//            }
//        }
//        """
//
//        let variables: [String: Any] = [
//            "customerAccessToken": customerId
//        ]
//
//        ApiCalling().callQueryApi(query: query, completion: {(result:Result<CustomerAddressCreates,NetworkError>) in
//            completion(result)
//        })
//    }
}

struct GraphQLResponse<T: Codable>: Codable {
    let data: T
}

struct CustomerAddressCreateResponse: Codable {
    let customerAddressCreate: CustomerAddressCreates?
}

struct CustomerAddressCreates: Codable {
    let customerAddress: CustomerAddress?
    let userErrors: [UserError]?
}

struct CustomerAddress: Codable {
    let id: String
    let address1: String?
}

struct CustomerDefaultAddressUpdateResponse: Codable {
    let customerDefaultAddressUpdate: CustomerDefaultAddressUpdate
}

struct CustomerDefaultAddressUpdate: Codable {
    let customer: DefaultCustomer?
    let userErrors: [UserError]?
}

struct DefaultCustomer: Codable {
    let defaultAddress: CustomerAddress?
}
