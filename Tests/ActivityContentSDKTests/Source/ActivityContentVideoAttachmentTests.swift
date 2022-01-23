//
//  ActivityContentVideoAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/13/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentVideoAttachmentTests: XCTestCase {
    
    func testActivityContentVideoAttachmentEncode() {
        let link = ActivityContentVideoLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .H265,
            hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = ActivityContentVideoAttachment(url: [link], name: "Video Attachment", duration: 180)
        
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
                  "href" : "http:\\/\\/www.example.com",
                  "mediaType" : "video\\/H265",
                  "type" : "Link"
                }
              ]
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentVideoAttachmentDecode() {
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
                  "mediaType" : "video/H265",
                  "type" : "Link"
                }
              ]
            }
            """
        
        let object = ActivityContentVideoAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Video")
        XCTAssertEqual(object?.name, "Video Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, .H265)
        XCTAssertTrue(try! object!.isValid())
    }
    
    func testActivityContentVideoAttachmentIsNotValid_InvalidType() {
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
                  "mediaType" : "video/mp4",
                  "type" : "Link"
                }
              ]
            }
            """
        
        let object = ActivityContentVideoAttachment(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidType)
        }
    }
    
    func testActivityContentVideoAttachmentIsNotValid_NonSupportedVideoFormat() {
        do {
            let object = ActivityContentVideoAttachment()
            let link = ActivityContentVideoLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .custom(mediaType: "video/unsupported"),
                hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.linksDoNotContainSupportedFormat)
        }
    }
    
    func testActivityContentVideoAttachmentIsValid() {
        let object = ActivityContentVideoAttachment()
        let link = ActivityContentVideoLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .H265,
            hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        object.url = [link]
        XCTAssertTrue(try! object.isValid())
    }
}
