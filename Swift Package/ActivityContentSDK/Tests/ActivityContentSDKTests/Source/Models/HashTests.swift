//
//  HashTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashTests: XCTestCase {
    
    func testHashInitWithInvalidHashValue() {
        do {
            _ = try Hash(algorithm: "keccak", value: "0x1234")
            XCTFail()
        } catch ActivityContentError.invalidHash {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testHashEncode() {
        let hash = try? Hash(algorithm: "keecak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
        
        let json = """
            {
              "algorithm" : "keecak",
              "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
            }
            """
        
        XCTAssertEqual(hash?.json, json)
    }
    
    func testHashDecode() {
        /// Note that when decoding, value is not checked for validity.
        let json = """
            {
              "algorithm" : "keecak",
              "value" : "0x1234"
            }
            """
        
        let object = Hash(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.algorithm, "keecak")
        XCTAssertEqual(object?.value, "0x1234")
    }
}
