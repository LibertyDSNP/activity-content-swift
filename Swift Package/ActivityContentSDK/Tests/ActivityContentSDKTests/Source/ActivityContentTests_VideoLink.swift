//
//  ActivityContentTests_VideoLink.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_VideoLink: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.VideoLink()
            .setHref(URL(string: "https://www.example.com")!)
            .setMediaType("video/mp4")
            .addHashes([
                try? ActivityContent.Builders.Hash()
                    .setAlgorithm("keccak")
                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.mediaType, "video/mp4")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.VideoLink(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keccak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "href" : "http://www.example.com",
              "mediaType" : "video/mp4",
              "type" : "Link"
            }
            """
        let object = try? ActivityContent.Builders.Attachments.VideoLink(json: json)?.build()
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "video/mp4")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "href" : "http://www.example.com",
              "mediaType" : "video/mp4",
              "type" : "Link"
            }
            """
        let builder = ActivityContent.Builders.Attachments.VideoLink(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
