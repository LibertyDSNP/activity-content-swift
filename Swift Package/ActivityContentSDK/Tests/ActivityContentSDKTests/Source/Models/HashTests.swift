//
//  HashTests.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashTests: XCTestCase {
    
    func testHashEncode() {
        let hash = Hash(algorithm: "keecak", value: "0x1234")
        
        let json = """
            {
              "algorithm" : "keecak",
              "value" : "0x1234"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: hash), json)
    }
    
    func testHashDecode() {
        let json = """
            {
              "algorithm" : "keecak",
              "value" : "0x1234"
            }
            """
        
        let object = TestUtil.object(with: Hash.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.algorithm, "keecak")
        XCTAssertEqual(object?.value, "0x1234")
    }
}