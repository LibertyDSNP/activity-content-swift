//
//  ActivityContentMentionTests.swift
//  
//
//  Created by Unfinished on 1/6/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentMentionTests: XCTestCase {
  
    func testMentionEncode() {
        let mention = ActivityContentMention(name: "Mention Name", id: "dsnp://1234")
        
        let json = """
            {
              "id" : "dsnp:\\/\\/1234",
              "name" : "Mention Name",
              "type" : "Mention"
            }
            """
        
        XCTAssertEqual(mention.json, json)
    }
    
    func testMentionDecode() {
        let json = """
            {
              "id" : "dsnp://1234",
              "name" : "Mention Name",
              "type" : "Mention"
            }
            """
        let object = ActivityContentMention(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Mention")
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
    }
    
    func testMentionIsNotValid_MissingDsnpUserUri() {
        do {
            let object = ActivityContentMention()
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingDsnpUserUriField)
        }
    }
    
    func testMentionIsNotValid_InvalidDsnpUserUri() {
        do {
            let object = ActivityContentMention()
            object.id = "dsnp://invalid"
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidDsnpUserUri)
        }
    }
    
    func testMentionIsValid() {
        let object = ActivityContentMention()
        object.id = "dsnp://1234"
        XCTAssertTrue(try! object.isValid())
    }
}

