//
//  HashUtilTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class HashUtilTests: XCTestCase {

    func testNilContent() {
        let nilHash = HashUtil.hash(content: nil)
        XCTAssertNil(nilHash)
    }

    func testContentToValidHash() {
        let hash = HashUtil.hash(content: "Lorem ipsum")
        XCTAssertEqual(hash, "0x4a63a2902ad43de8c568bb4a8acbe12e95e8fbfb3babf985ea871e9fccf2dadb")
    }
}
