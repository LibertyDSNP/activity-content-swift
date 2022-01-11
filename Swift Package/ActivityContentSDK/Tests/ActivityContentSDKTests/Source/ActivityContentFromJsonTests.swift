//
//  ActivityContentFromJsonTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/11/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentFromJsonTests: XCTestCase {
    
    func testGetValueWithCustomFields() {
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
        
        /// Verify that we can access custom values as various native types
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
        
        /// Verify that we do not prevent users from accessing native vars
        let href = object?.getValue(key: "href") as? String
        XCTAssertEqual(href, "http://www.example.com")
        
        /// Verify that attempting to access non-existant value returns nil
        let missingValue = object?.getValue(key: "missing")
        XCTAssertNil(missingValue)
    }
}
