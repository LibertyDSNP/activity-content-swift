//
//  ActivityContentTests_Hashtag.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_Hashtag: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Tags.Hashtag()
            .setName("#hashtag")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.name, "#hashtag")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Tags.Hashtag(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "name" : "#hashtag"
            }
            """
        let object = try? ActivityContent.Builders.Tags.Hashtag(json: json)?.build()
        XCTAssertEqual(object?.name, "#hashtag")
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
            }
            """
        let builder = ActivityContent.Builders.Tags.Hashtag(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
