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
    
    func testBaseLinkCustomField() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link",
              "custom" : {
                 "bool" : true,
                 "string" : "string",
                 "int" : 1,
                 "float" : 1.0
              }
            }
            """
        let object = BaseLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        
        let customDictionary = object?.getValue(key: "custom")
        XCTAssertNotNil(customDictionary)
        if let customDictionary = customDictionary as? [String : Any] {
            let customBool = customDictionary["bool"] as? Bool
            XCTAssertEqual(customBool, true)
            let customString = customDictionary["string"] as? String
            XCTAssertEqual(customString, "string")
            let customInt = customDictionary["int"] as? Int
            XCTAssertEqual(customInt, 1)
            let customFloat = customDictionary["float"] as? Float
            XCTAssertEqual(customFloat, 1.0)
        } else {
            XCTFail()
        }
    }
}