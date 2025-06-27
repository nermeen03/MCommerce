//
//  FakeNetworkTest.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 28/06/2025.
//

import XCTest

final class FakeNetworkTest: XCTestCase{
    func testNetworkFail(){
        let fakeNetwork = FakeNetworkServices(shouldFail: true)
        fakeNetwork.request(url: "", responseType: TestClass.self, completion: {
            result in
            switch result {
            case .success:
                XCTFail("Should have failed")
            case .failure:
                XCTAssertTrue(true)
            }
        })
    }
    func testNetworkSuccess(){
        let fakeNetwork = FakeNetworkServices(shouldFail: false)
        fakeNetwork.request(url: "", responseType: TestClass.self, completion: {
            result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Should have succeeded")
            }
        })
    }
}
