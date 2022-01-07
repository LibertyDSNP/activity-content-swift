//
//  MentionTests.swift
//  
//
//  Created by Rigo Carbajal on 1/6/22.
//

import XCTest
@testable import ActivityContentSDK

class MentionTests: XCTestCase {
    
    func testMentionInitWithInvalidId() {
        do {
            _ = try Mention(name: "Mention Name", id: "user_id")
            XCTFail()
        } catch ActivityContentError.invalidDsnpUserUri {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testMentionEncode() {
        let mention = try? Mention(name: "Mention Name", id: "dsnp://1234")
        
        let json = """
            {
              "id" : "dsnp:\\/\\/1234",
              "name" : "Mention Name",
              "type" : "Mention"
            }
            """
        
        XCTAssertEqual(mention?.json, json)
    }
    
    func testMentionDecode() {
        let json = """
            {
              "id" : "dsnp://1234",
              "name" : "Mention Name",
              "type" : "Mention"
            }
            """
        let object = Mention.from(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Mention")
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
    }
}

