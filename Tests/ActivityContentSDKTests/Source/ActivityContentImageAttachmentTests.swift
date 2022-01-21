//
//  ActivityContentImageAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentImageAttachmentTests: XCTestCase {

    func testActivityContentImageAttachmentEncode() {
        let link = ActivityContentImageLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .png,
            hash: [ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = ActivityContentImageAttachment(url: [link], name: "Image Attachment")
        
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
                  "href" : "http:\\/\\/www.example.com",
                  "mediaType" : "image\\/png",
                  "type" : "Link"
                }
              ]
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentImageAttachmentDecode() {
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
        
        let object = ActivityContentImageAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Image")
        XCTAssertEqual(object?.name, "Image Attachment")
        XCTAssertEqual(object?.url?.first?.mediaType, .png)
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testActivityContentImageAttachmentIsNotValid_InvalidType() {
        let json = """
            {
              "type" : "Invalid",
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
        
        let object = ActivityContentImageAttachment(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch ActivityContentError.invalidType {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentImageAttachmentIsNotValid_NonSupportedImageFormat() {
        do {
            let object = ActivityContentImageAttachment()
            let link = ActivityContentImageLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .custom(mediaType: "image/unsupported"),
                hash: [ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.linksDoNotContainSupportedFormat {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentImageAttachmentIsValid() {
        do {
            let object = ActivityContentImageAttachment()
            let link = ActivityContentImageLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .png,
                hash: [ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
