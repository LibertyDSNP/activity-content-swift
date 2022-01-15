//
//  ActivityContentToJsonTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/13/22.
//

import XCTest
@testable import ActivityContentSDK

private class ObjectThatFailsEncoding: ActivityContentToJson {
    private var infinityDouble: Double = Double.infinity
}

class ActivityContentToJsonTests: XCTestCase {
    
    func testActivityContentBaseLinkToJson() {
        let object = ActivityContentBaseLink(href: URL(string: "http://www.example.com")!)
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testInvalidFormattedJson() {
        let object = ObjectThatFailsEncoding()
        XCTAssertNil(object.json)
    }
    
    func testSetAdditionalFieldsToJson() {
        let object = ActivityContentBaseLink(href: URL(string: "http://www.example.com")!)
        object.addAdditionalFields([
            /// Any key that matches a native var is excluded from the encoded JSON
            "href" : "http://www.attemptToOverride.com",
            "type" : "ATTEMPT_TO_OVERRIDE",
            
            /// String : String
            "string" : "test",
            
            /// String : [Int]
            "intArray" : [
                1,
                2,
                3
            ],
            
            /// String : [<Mixed>]
            "mixedArray" : [
                100,
                42.24,
                ActivityContentBaseLink(href: URL(string: "http://www.example.com")!),
                false,
                "string",
                [
                    [
                        "key" : "value",
                        "bool" : true
                    ]
                ]
            ]
        ])
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "intArray" : [
                1,
                2,
                3
              ],
              "mixedArray" : [
                100,
                42.240000000000002,
                {
                  "href" : "http:\\/\\/www.example.com",
                  "type" : "Link"
                },
                false,
                "string",
                [
                  {
                    "bool" : true,
                    "key" : "value"
                  }
                ]
              ],
              "string" : "test",
              "type" : "Link"
            }
            """
    
        XCTAssertEqual(object.json!, json)
    }
}
