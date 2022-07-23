//
//  NetworkManagerTests.swift
//  MegamartTests
//
//  Created by MAC on 18/07/2022.
//

import XCTest
@testable import Megamart

class NetworkManagerTests: XCTestCase {

    var apiService: APIServices?
    
    override func setUp() {
        apiService = NetworkManagerMock(shouldReturnError: false)
    }
    
    override func tearDown() {
        apiService = nil
    }
    
    func testFetchProductInfo() {
        apiService?.fetchProductInfo(endPoint: "7730623709398", completion: { product, error in
            XCTAssertNotNil(product)
            XCTAssertNil(error)
        })
    }

    func testRetriveCustomers() {
        apiService?.retriveCustomers(completion: { customers, error in
            XCTAssertNotNil(customers)
            XCTAssertNil(error)
        })

    }


}
