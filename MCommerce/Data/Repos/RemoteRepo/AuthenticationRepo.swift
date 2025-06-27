
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
    
    var emailCheckTimer: Timer?
    var remainingChecks = 40
    func register(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
      FireBaseAuthHelper.shared.registerWithFirebase(email: user.email, password: user.password)
        remainingChecks = 40
        emailCheckTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            FireBaseAuthHelper.shared.checkEmailVerificationStatus { isVerified in
                if isVerified {
                    self.emailCheckTimer?.invalidate()
                    self.emailCheckTimer = nil
                    self.registerToShopify(user: user, completion: completion)
                } else {
                    self.remainingChecks -= 1
                 
                    
                    if self.remainingChecks <= 0 {
                        self.emailCheckTimer?.invalidate()
                        self.emailCheckTimer = nil
                      
                        completion(.failure(.custom(message: "Email was not verified")))
                    }
                }
            }
        }
        
        
    }
    func registerToShopify(user: User, completion: @escaping (Result<Customer, NetworkError>) -> Void) {
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
                        completion(.failure(NetworkError.custom(message: response.data.customerCreate?.customerUserErrors.first?.message ?? "Error")))
                       
                    }
                
                case .failure(let error):
                    completion(.failure(.custom(message: error.localizedDescription)))
                
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
                                completion(.success(customerAccessToken))
                        }
                        else{
                            completion(.failure(NetworkError.custom(message: response.data.customerAccessTokenCreate.userErrors.first?.message ?? "Wrong Credentials")))
                        }
                      

                    case .failure(let error):
                        completion(.failure(NetworkError.custom(message: error.localizedDescription)))
                
                    }
                }
            )
    }
   

    
    
}
//class MyError : Error {
//    var message: String
//    init(message: String) {
//        self.message = message
//    }
//}
