//
//  ActivityContentSDKTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentSDKTests: XCTestCase {   

    func testPrintImageLink() {
        let imageLink = ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: "0x1234")], height: 400, width: 400)
        print(TestUtil.json(object: imageLink)!)
    }
    
    func testInitFromJSON_ImageLink() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x1234"
                }
              ],
              "height" : 400,
              "href" : "http://www.example.com",
              "mediaType" : "image/png",
              "type" : "Link",
              "width" : 300
            }
            """
        let object = TestUtil.object(with: ImageLink.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.height, 400)
        XCTAssertEqual(object?.width, 300)
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "image/png")
    }
    
}
