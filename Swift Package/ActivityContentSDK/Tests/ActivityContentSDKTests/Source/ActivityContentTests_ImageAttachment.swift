//
//  ActivityContentTests_ImageAttachment.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests_ImageAttachment: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Attachments.Image()
            .setName("Image Attachment")
            .addImageLinks([
                try! ActivityContent.Builders.Attachments.ImageLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("image/png")
                    .addHashes([
                        try! ActivityContent.Builders.Hash()
                            .setAlgorithm("keccak")
                            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Image")
        XCTAssertEqual(object?.name, "Image Attachment")
        XCTAssertEqual(object?.url?.first?.mediaType, "image/png")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Attachments.Image(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "name" : "Image Attachment",
              "type" : "Image",
              "url" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "keccak",
                      "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                    }
                  ],
                  "href" : "http://www.example.com",
                  "mediaType" : "image/png",
                  "type" : "Link"
                }
              ]
            }
            """
        let object = try? ActivityContent.Builders.Attachments.Image(json: json)?.build()
        XCTAssertEqual(object?.type, "Image")
        XCTAssertEqual(object?.name, "Image Attachment")
        XCTAssertEqual(object?.url?.first?.mediaType, "image/png")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "name" : "Image Attachment",
              "type" : "Image"
            }
            """
        let builder = ActivityContent.Builders.Attachments.Image(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
