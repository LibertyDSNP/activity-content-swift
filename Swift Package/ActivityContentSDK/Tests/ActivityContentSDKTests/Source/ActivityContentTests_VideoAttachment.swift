//
//  ActivityContentTests_VideoAttachment.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_VideoAttachment: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.Video()
            .setName("Video Attachment")
            .addVideoLinks([
                try? ActivityContent.Builders.Attachments.VideoLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("video/mp4")
                    .addHashes([
                        try? ActivityContent.Builders.Hash()
                            .setAlgorithm("keccak")
                            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .addDuration(180)
            .addAdditionalFields(["custom_1" : true, "custom_2" : true])
            .addAdditionalFields(["custom_1" : false])
            .build()
        
        XCTAssertEqual(object?.type, "Video")
        XCTAssertEqual(object?.name, "Video Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "video/mp4")
        XCTAssertEqual(object?.additionalFields["custom_1"] as? Bool, false)
        XCTAssertEqual(object?.additionalFields["custom_2"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.Video(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "duration" : 180,
              "name" : "Video Attachment",
              "type" : "Video",
              "url" : [
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
              ]
            }
            """
        let object = try? ActivityContent.Builders.Attachments.Video(json: json)?.build()
        XCTAssertEqual(object?.type, "Video")
        XCTAssertEqual(object?.name, "Video Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "video/mp4")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "name" : "Video Attachment",
              "type" : "Video"
            }
            """
        let builder = ActivityContent.Builders.Attachments.Video(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
