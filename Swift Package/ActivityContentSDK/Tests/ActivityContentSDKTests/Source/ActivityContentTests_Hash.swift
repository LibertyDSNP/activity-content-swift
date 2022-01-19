//
//  ActivityContentTests_Hash.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_Hash: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Hash()
            .withAlgorithm("keccak")
            .withValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.algorithm, "keccak")
        XCTAssertEqual(object?.value, "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithKeccakInitWithString() {
        let object = try? ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.algorithm, "keccak")
        XCTAssertEqual(object?.value, "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithKeccakInitWithData() {
        let data = "Lorem Ipsum".data(using: .utf8)
        let object = try? ActivityContent.Builders.Hash(keccakHashWithData: data)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.algorithm, "keccak")
        XCTAssertEqual(object?.value, "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Hash(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "algorithm" : "keccak",
              "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
            }
            """
        let object = try? ActivityContent.Builders.Hash(json: json)?.build()
        XCTAssertEqual(object?.algorithm, "keccak")
        XCTAssertEqual(object?.value, "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "algorithm" : "keccak",
              "value" : "invalid"
            }
            """
        let builder = ActivityContent.Builders.Hash(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
