//
//  AuthenticationRepo.swift
//  MCommerce
//
//  Created by Jailan Medhat on 17/06/2025.
//
import Foundation


class AuthenticationRepo : AuthenticationRepositoryProtocol , ObservableObject {
    func getUserId(accessToken: String, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
        let query = """
        {
          customer(customerAccessToken: "\(accessToken)") {
            id
            email
            firstName
            lastName
          }
        }
        """

        ApiCalling().callQueryApi(
            query: query,
            variables: [:],
            completion: { (result: Result<GetCustomerResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    if let customer = response.data.customer {
                        completion(.success(customer))
                    } else {
                        completion(.failure(.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
//    let remoteService : RemoteServicesProtocol
//    
//    init(remoteService: RemoteServicesProtocol) {
//        self.remoteService = remoteService
//    }
    func register(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
        let createCustomerMutation = """
        mutation customerCreate($input: CustomerCreateInput!) {
          customerCreate(input: $input) {
            customer {
              id
              email
              firstName
              lastName
            }
            customerUserErrors {
              field
              message
            }
          }
        }
        """

        let variables: [String: Any] = [
            "input": [
                "firstName": user.firstName,
                "lastName": user.lastName,
                "email": user.email,
                "phone": user.phoneNumber,
                "password": user.password,
                "acceptsMarketing": true
            ]
        ]

        ApiCalling().callQueryApi(
            query: createCustomerMutation,
            variables: variables,
            completion: { (result: Result<CreateCustomerResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    if let customer = response.data.customerCreate?.customer {
                        completion(.success((response.data.customerCreate?.customer!)!))
                        self.sendInvite(for: user.email) { inviteResult in
                            switch inviteResult {
                            case .success():
                                print("Invite Sent to: \(customer.email)")
                            case .failure(let error):
                                print("Invite Error: \(error)")
                            }
                        }
                    }else{
                        completion(.failure(NetworkError.invalidResponse))
                    }
                    
                   // print("✅ Customer created: \(response.data.customerCreate.customer?.email ?? "No Email")")
                case .failure(let error):
                    completion(.failure(error))
                  //  print("❌ Customer creation failed: \(error)")
                }
            }
        )
    }
    
    func sendInvite(for customerID: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {

        let graphqlQuery = """
        mutation customerSendInvite($id: ID!) {
            customerSendInvite(id: $id) {
                customerInvite {
                    to
                    from
                    subject
                }
                userErrors {
                    message
                }
            }
        }
        """

        ApiCalling().callQueryApi(query: graphqlQuery,useToken: true ,completion: {
            (result : Result<ProductTest,NetworkError>) in
            print(result)
        })
    }

    
    func login(email: String, password: String, completion: @escaping (Result<CustomerAccessToken, NetworkError>) -> Void) {
       
            let loginQuery = """
            mutation customerAccessTokenCreate($input: CustomerAccessTokenCreateInput!) {
              customerAccessTokenCreate(input: $input) {
                customerAccessToken {
                  accessToken
                  expiresAt
                }
                userErrors {
                  field
                  message
                }
              }
            }
            """

            let variables: [String: Any] = [
                "input": [
                    "email": email,
                    "password": password
                ]
            ]

            ApiCalling().callQueryApi(
                query: loginQuery,
                variables: variables,
                completion: { (result: Result<LoginResponse, NetworkError>) in
                   // completion(result)
                    switch result {
                    case .success(let response):
                        if let customerAccessToken = response.data.customerAccessTokenCreate.customerAccessToken {
                            completion(.success(response.data.customerAccessTokenCreate.customerAccessToken!))
                        }
                        else{
                            completion(.failure(NetworkError.invalidResponse))
                        }
                      
//                        if let token = response.data.customerAccessTokenCreate.customerAccessToken?.accessToken {
//                            print("✅ Login successful, token: \(token)")
//                        } else {
//                            print("❌ Login failed, error: \(response.data.customerAccessTokenCreate.userErrors.first?.message ?? "Unknown")")
//                        }
                    case .failure(let error):
                        completion(.failure(error))
                      //  print("❌ GraphQL login error: \(error)")
                    }
                }
            )
    }
   

    
    
}

