//
//  ActivityContentTests_LinkAttachment.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_LinkAttachment: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.Link()
            .withName("Link Attachment")
            .withHref(URL(string: "https://www.example.com")!)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.name, "Link Attachment")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.Link(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "href" : "https://www.example.com",
              "name" : "Link Attachment",
              "type" : "Link"
            }
            """
        let object = try? ActivityContent.Builders.Attachments.Link(json: json)?.build()
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.name, "Link Attachment")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "name" : "Link Attachment",
              "type" : "Link"
            }
            """
        let builder = ActivityContent.Builders.Attachments.Link(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
