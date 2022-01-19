//
//  ActivityContentItemTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/14/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentItemTests: XCTestCase {
    
    func testDefaultIsValid() {
        let activityContentItem = ActivityContentItem()
        XCTAssertTrue(try activityContentItem.isValid())
    }
}
