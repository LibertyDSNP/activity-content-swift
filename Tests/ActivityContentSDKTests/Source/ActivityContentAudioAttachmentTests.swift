//
//  ActivityContentAudioAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentAudioAttachmentTests: XCTestCase {

    func testActivityContentAudioAttachmentEncode() {
        let link = ActivityContentAudioLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .ogg,
            hash: [ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = ActivityContentAudioAttachment(url: [link], name: "Audio Attachment", duration: 180)
        
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
                  "href" : "http:\\/\\/www.example.com",
                  "mediaType" : "audio\\/ogg",
                  "type" : "Link"
                }
              ]
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentAudioAttachmentDecode() {
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
        
        let object = ActivityContentAudioAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Audio")
        XCTAssertEqual(object?.name, "Audio Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, .ogg)
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testActivityContentAudioAttachmentIsNotValid_NonSupportedAudioFormat() {
        do {
            let object = ActivityContentAudioAttachment()
            let link = ActivityContentAudioLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .custom(mediaType: "audio/unsupported"),
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
    
    func testActivityContentAudioAttachmentIsNotValid_InvalidType() {
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
                  "mediaType" : "audio/ogg",
                  "type" : "Link"
                }
              ]
            }
            """
        
        let object = ActivityContentAudioAttachment(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch ActivityContentError.invalidType {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioAttachmentIsNotValid_NonSupportedHash() {
        let json = """
            {
              "type" : "Audio",
              "url" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "invalid",
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
        
        let object = ActivityContentAudioAttachment(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch ActivityContentError.hashesDoNotContainSupportedAlgorithm {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioAttachmentIsValid() {
        do {
            let object = ActivityContentAudioAttachment()
            let link = ActivityContentAudioLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .ogg,
                hash: [ActivityContentHash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
