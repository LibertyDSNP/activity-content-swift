//
//  ActivityContentTests_AudioAttachment.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_AudioAttachment: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.Audio()
            .withName("Audio Attachment")
            .addAudioLinks([
                try? ActivityContent.Builders.Attachments.AudioLink()
                    .withHref(URL(string: "https://www.example.com")!)
                    .withMediaType("audio/ogg")
                    .addHashes([
                        try? ActivityContent.Builders.Hash()
                            .withAlgorithm("keccak")
                            .withValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .addDuration(180)
            .addAdditionalFields(["custom_1" : true, "custom_2" : true])
            .addAdditionalFields(["custom_1" : false])
            .build()
        
        XCTAssertEqual(object?.type, "Audio")
        XCTAssertEqual(object?.name, "Audio Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "audio/ogg")
        XCTAssertEqual(object?.additionalFields["custom_1"] as? Bool, false)
        XCTAssertEqual(object?.additionalFields["custom_2"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.Audio(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "duration" : 180,
              "name" : "Audio Attachment",
              "type" : "Audio",
              "url" : [
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
              ]
            }
            """
        let object = try? ActivityContent.Builders.Attachments.Audio(json: json)?.build()
        XCTAssertEqual(object?.type, "Audio")
        XCTAssertEqual(object?.name, "Audio Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "audio/ogg")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "name" : "Audio Attachment",
              "type" : "Audio"
            }
            """
        let builder = ActivityContent.Builders.Attachments.Audio(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
