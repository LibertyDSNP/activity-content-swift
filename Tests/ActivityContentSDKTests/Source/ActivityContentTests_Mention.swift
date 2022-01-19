//
//  ActivityContentTests_Mention.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_Mention: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Tags.Mention()
            .withName("Mention Name")
            .withDSNPUserId("dsnp://1234")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Mention")
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Tags.Mention(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "id" : "dsnp://1234",
              "name" : "Mention Name",
              "type" : "Mention"
            }
            """
        let object = try? ActivityContent.Builders.Tags.Mention(json: json)?.build()
        XCTAssertEqual(object?.type, "Mention")
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "id" : "dsnp://1234",
              "name" : "Mention Name",
              "type" : "Invalid"
            }
            """
        let builder = ActivityContent.Builders.Tags.Mention(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
