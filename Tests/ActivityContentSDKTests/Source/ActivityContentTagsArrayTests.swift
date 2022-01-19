//
//  TagsArrayTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class TagsArrayTests: XCTestCase {
    
    func testTagsArrayDecode() {
        let json = """
            [{
              "name" : "#hashtag1"
            },
            {
              "name" : "Mention Name 1",
              "type" : "Mention",
              "id" : "dsnp://user1"
            },
            {
              "name" : "#hashtag2"
            },
            {
              "name" : "Mention Name 2",
              "type" : "Mention",
              "id" : "dsnp://user2"
            }]
            """
        
        let object = ActivityContentTagsArray(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.tags?.count, 4)
        XCTAssertEqual((object?.tags?[0] as? ActivityContentHashtag)?.name, "#hashtag1")
        XCTAssertEqual((object?.tags?[1] as? ActivityContentMention)?.id, "dsnp://user1")
        XCTAssertEqual((object?.tags?[2] as? ActivityContentHashtag)?.name, "#hashtag2")
        XCTAssertEqual((object?.tags?[3] as? ActivityContentMention)?.id, "dsnp://user2")
    }
}
