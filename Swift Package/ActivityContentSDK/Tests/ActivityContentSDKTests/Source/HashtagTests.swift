//
//  HashtagTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class HashtagTests: XCTestCase {

    func testHashtagEncode() {
        let object = Hashtag(name: "#hashtag")
        
        let json = """
            {
              "name" : "#hashtag"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testHashtagDecode() {
        let json = """
            {
              "name" : "#hashtag"
            }
            """
        let object = Hashtag(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.name, "#hashtag")
    }
    
    func testHashtagIsNotValid_MissingName() {
        do {
            let object = Hashtag()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingNameField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testHashtagIsValid() {
        do {
            let object = Hashtag()
            object.name = "#hashtag"
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
