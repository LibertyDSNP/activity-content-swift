//
//  AudioAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class AudioAttachmentTests: XCTestCase {

    func testAudioAttachmentEncode() {
        let link = AudioLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "audio/ogg",
            hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = AudioAttachment(url: [link], name: "Audio Attachment", duration: 180)
        
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
    
    func testAudioAttachmentDecode() {
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
        
        let object = AudioAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Audio")
        XCTAssertEqual(object?.name, "Audio Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "audio/ogg")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testAudioAttachmentIsNotValid_NonSupportedAudioFormat() {
        do {
            let object = AudioAttachment()
            let link = AudioLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "audio/unsupported",
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
    
    func testAudioAttachmentIsValid() {
        do {
            let object = AudioAttachment()
            let link = AudioLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "audio/ogg",
                hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
