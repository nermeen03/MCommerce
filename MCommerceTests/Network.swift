//
//  Network.swift
//  MCommerceTests
//
//  Created by Jailan Medhat on 30/06/2025.
//

import XCTest
@testable import MCommerce
final class Network: XCTestCase {
    var apiService : RemoteServicesProtocol!
    override func setUpWithError() throws {
        apiService = ApiCalling()
     
    }

    override func tearDownWithError() throws {
     
    }

    func testNetwork() throws {
        let expectation = self.expectation(description: "Wait for API response")
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
                "email": "jailanmedhatt2@gmail.com",
                "password": "123456"
            ]
        ]

        apiService.callQueryApi(
        
            query: loginQuery,
            variables: variables,
            useToken: false,
            completion: { (result: Result<LoginResponse, NetworkError>) in
                switch result {
                case .success(let response):
                    guard let customerAccessToken = response.data.customerAccessTokenCreate.customerAccessToken else {
                        XCTFail("Customer access token not found")
                        expectation.fulfill()
                        return
                    }
                    XCTAssertNotNil(customerAccessToken)
                    expectation.fulfill()

                case .failure(let error):
                    XCTFail(error.localizedDescription)
            
                }
            }
        )
        waitForExpectations(timeout: 5, handler: nil)
    }

    

}
