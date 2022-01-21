//
//  ActivityContentTests_AudioLink.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_AudioLink: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.AudioLink()
            .withHref(URL(string: "https://www.example.com")!)
            .withMediaType(.ogg)
            .addHashes([
                try? ActivityContent.Builders.Hash()
                    .withAlgorithm("keccak")
                    .withValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.mediaType, .ogg)
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.AudioLink(json: "invalid")
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
              "mediaType" : "audio/ogg",
              "type" : "Link"
            }
            """
        let object = try? ActivityContent.Builders.Attachments.AudioLink(json: json)?.build()
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, .ogg)
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "href" : "http://www.example.com",
              "mediaType" : "audio/ogg",
              "type" : "Link"
            }
            """
        let builder = ActivityContent.Builders.Attachments.AudioLink(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
