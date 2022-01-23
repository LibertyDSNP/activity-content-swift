//
//  HashTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashTests: XCTestCase {

    func testKeccakInitWithString() {
        let object = ActivityContentHash(keccakHashWithString: "Lorem Ipsum")
        XCTAssertEqual(object.algorithm, .keccak)
        XCTAssertEqual(object.value, "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345")
    }
    
    func testKeccakInitWithData() {
        let data = "Lorem Ipsum".data(using: .utf8)
        let object = ActivityContentHash(keccakHashWithData: data)
        XCTAssertEqual(object.algorithm, .keccak)
        XCTAssertEqual(object.value, "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345")
    }
    
    func testHashEncode() {
        let object = ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
        
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
        XCTAssertEqual(object?.algorithm, .keccak)
        XCTAssertEqual(object?.value, "0x1234")
    }
    
    func testHashIsNotValid_MissingAlgorithm() {
        do {
            let object = ActivityContentHash()
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingAlgorithmField)
        }
    }
    
    func testHashIsNotValid_MissingHashValue() {
        do {
            let object = ActivityContentHash()
            object.algorithm = .custom(algorithm: "algorithm")
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingHashValueField)
        }
    }
    
    func testHashIsNotValid_InvalidHashValue() {
        do {
            let object = ActivityContentHash()
            object.algorithm = .custom(algorithm: "algorithm")
            object.value = "0xinvalid"
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidHash)
        }
    }
    
    func testHashIsValid() {
        let object = ActivityContentHash()
        object.algorithm = .custom(algorithm: "algorithm")
        object.value = "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
        XCTAssertTrue(try! object.isValid())
    }
    
    func testAlgorithmTypes() {
        let keccak = ActivityContentHash.AlgorithmType(string: "keccak")
        let custom = ActivityContentHash.AlgorithmType(string: "custom")
        XCTAssertEqual(keccak?.stringValue, "keccak")
        XCTAssertEqual(custom?.stringValue, "custom")
    }
}
