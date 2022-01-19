//
//  ActivityContentHashtagTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentHashtagTests: XCTestCase {

    func testActivityContentHashtagEncode() {
        let object = ActivityContentHashtag(name: "#hashtag")
        
        let json = """
            {
              "name" : "#hashtag"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentHashtagDecode() {
        let json = """
            {
              "name" : "#hashtag"
            }
            """
        let object = ActivityContentHashtag(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.name, "#hashtag")
    }
    
    func testActivityContentHashtagIsNotValid_MissingName() {
        do {
            let object = ActivityContentHashtag()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingNameField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentHashtagIsValid() {
        do {
            let object = ActivityContentHashtag()
            object.name = "#hashtag"
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
