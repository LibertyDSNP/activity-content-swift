//
//  ActivityContentFromJsonTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/11/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentFromJsonTests: XCTestCase {
    
    func testBaseLinkWithCustomFields() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link",
              "custom" : {
                 "bool" : true,
                 "string" : "string",
                 "int" : 1,
                 "float" : 1.4
              },
              "not_href" : true
            }
            """
        let object = BaseLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        
        /// Verify that we can access custom values as various native types
        let customDictionary = object?.additionalFields?["custom"]
        XCTAssertNotNil(customDictionary)
        if let customDictionary = customDictionary as? [String : Any] {
            let customBool = customDictionary["bool"] as? Bool
            XCTAssertEqual(customBool, true)
            let customString = customDictionary["string"] as? String
            XCTAssertEqual(customString, "string")
            let customInt = customDictionary["int"] as? Int
            XCTAssertEqual(customInt, 1)
            let customFloat = customDictionary["float"] as? Double
            XCTAssertEqual(customFloat, 1.4)
        } else {
            XCTFail()
        }
        
        /// Verify that additionalFields does not contain native vars
        let href = object?.additionalFields?["href"]
        XCTAssertNil(href)

        /// Verify that attempting to access non-existant value returns nil
        let missingValue = object?.additionalFields?["missing"]
        XCTAssertNil(missingValue)
    }
    
    func testImageLinkWithCustomFields() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keccak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "href" : "http://www.example.com",
              "mediaType" : "image/png",
              "type" : "Link",
              "custom" : {
                 "bool" : true,
                 "string" : "string",
                 "int" : 1,
                 "float" : 1.4
              },
              "boolCustom" : true
            }
            """
        
        let object = ImageLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "image/png")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertTrue(try object?.isValid() ?? false)
        
        /// Verify that we can access custom values as various native types
        let customDictionary = object?.additionalFields?["custom"]
        XCTAssertNotNil(customDictionary)
        if let customDictionary = customDictionary as? [String : Any] {
            let customBool = customDictionary["bool"] as? Bool
            XCTAssertEqual(customBool, true)
            let customString = customDictionary["string"] as? String
            XCTAssertEqual(customString, "string")
            let customInt = customDictionary["int"] as? Int
            XCTAssertEqual(customInt, 1)
            let customFloat = customDictionary["float"] as? Double
            XCTAssertEqual(customFloat, 1.4)
        } else {
            XCTFail()
        }
        
        let boolCustom = object?.additionalFields?["boolCustom"] as? Bool
        XCTAssertEqual(boolCustom, true)
    }
}
