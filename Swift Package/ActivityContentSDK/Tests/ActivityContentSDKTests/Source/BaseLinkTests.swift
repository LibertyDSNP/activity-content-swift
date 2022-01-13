//
//  BaseLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/6/22.
//

import XCTest
@testable import ActivityContentSDK

class BaseLinkTests: XCTestCase {
    
    func testBaseLinkEncode() {
        let object = BaseLink(href: URL(string: "http://www.example.com")!)
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testBaseLinkDecode() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link"
            }
            """
        let object = BaseLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
    }
    
    func testBaseLinkCustomFields() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link",
              "float" : 1.4,
              "int" : 1,
              "double" : 3.14159,
              "dictionary" : {
                 "bool" : true
              }
            }
            """
        
        let object = BaseLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        
        let float = object?.additionalFields?["float"] as? Double
        XCTAssertEqual(float, 1.4)
        let int = object?.additionalFields?["int"] as? Int
        XCTAssertEqual(int, 1)
        let double = object?.additionalFields?["double"] as? Double
        XCTAssertEqual(double, 3.14159)
        let dictionary = object?.additionalFields?["dictionary"]
        XCTAssertNotNil(dictionary)
        if let dictionary = dictionary as? [String : Any] {
            let bool = dictionary["bool"] as? Bool
            XCTAssertEqual(bool, true)
        } else {
            XCTFail()
        }
    }
}
