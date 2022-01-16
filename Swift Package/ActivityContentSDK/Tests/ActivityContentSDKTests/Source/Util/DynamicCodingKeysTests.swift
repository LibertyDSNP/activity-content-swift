//
//  DynamicCodingKeysTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/14/22.
//

import XCTest
@testable import ActivityContentSDK

class DynamicCodingKeysTests: XCTestCase {
    
    func testDynamicCodingKeysInit() {
        let intKey = DynamicCodingKeys(intValue: 2)
        XCTAssertNil(intKey?.intValue)
        let stringKey = DynamicCodingKeys(stringValue: "HelloWorld")
        XCTAssertEqual(stringKey?.stringValue, "HelloWorld")
    }
}
