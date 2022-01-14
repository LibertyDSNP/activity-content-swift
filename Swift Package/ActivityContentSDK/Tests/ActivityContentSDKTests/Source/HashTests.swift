//
//  HashTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashTests: XCTestCase {

    func testHashEncode() {
        let object = ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
        
        let json = """
            {
              "algorithm" : "keccak",
              "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testHashDecode() {
        /// Note that when decoding, value is not checked for validity.
        let json = """
            {
              "algorithm" : "keccak",
              "value" : "0x1234"
            }
            """
        
        let object = ActivityContentHash(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.algorithm, "keccak")
        XCTAssertEqual(object?.value, "0x1234")
    }
    
    func testHashIsNotValid_MissingAlgorithm() {
        do {
            let object = ActivityContentHash()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingAlgorithmField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testHashIsNotValid_MissingHashValue() {
        do {
            let object = ActivityContentHash()
            object.algorithm = "algorithm"
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHashValueField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testHashIsNotValid_InvalidHashValue() {
        do {
            let object = ActivityContentHash()
            object.algorithm = "algorithm"
            object.value = "0xinvalid"
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHash {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testHashIsValid() {
        do {
            let object = ActivityContentHash()
            object.algorithm = "algorithm"
            object.value = "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
