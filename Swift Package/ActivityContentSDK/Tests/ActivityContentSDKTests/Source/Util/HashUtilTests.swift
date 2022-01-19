//
//  HashUtilTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashUtilTests: XCTestCase {

    func testNilStringContent() {
        let nilHash = HashUtil.hash(string: nil)
        XCTAssertNil(nilHash)
    }

    func testStringContentToValidHash() {
        let hash = HashUtil.hash(string: "Lorem ipsum")
        XCTAssertEqual(hash, "0x4a63a2902ad43de8c568bb4a8acbe12e95e8fbfb3babf985ea871e9fccf2dadb")
    }
    
    func testNilDataContent() {
        let nilHash = HashUtil.hash(data: nil)
        XCTAssertNil(nilHash)
    }

    func testDataContentToValidHash() {
        let data = "Lorem ipsum".data(using: .utf8)
        let hash = HashUtil.hash(data: data)
        XCTAssertEqual(hash, "0x4a63a2902ad43de8c568bb4a8acbe12e95e8fbfb3babf985ea871e9fccf2dadb")
    }
}
