//
//  VideoAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/13/22.
//

import XCTest
@testable import ActivityContentSDK

class VideoAttachmentTests: XCTestCase {

    func testVideoAttachmentEncode() {
        let link = VideoLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "video/H265",
            hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = VideoAttachment(url: [link], name: "Video Attachment", duration: 180)
        
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
    
    func testVideoAttachmentDecode() {
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
        
        let object = VideoAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Video")
        XCTAssertEqual(object?.name, "Video Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "video/H265")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testVideoAttachmentIsNotValid_NonSupportedVideoFormat() {
        do {
            let object = VideoAttachment()
            let link = VideoLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "video/unsupported",
                hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.linksDoNotContainSupportedFormat {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testVideoAttachmentIsValid() {
        do {
            let object = VideoAttachment()
            let link = VideoLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "video/H265",
                hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
