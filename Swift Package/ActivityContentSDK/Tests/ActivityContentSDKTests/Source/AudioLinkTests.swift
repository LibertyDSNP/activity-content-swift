//
//  ActivityContentAudioLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentAudioLinkTests: XCTestCase {

    func testActivityContentAudioLinkEncode() {
        let object = ActivityContentAudioLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "audio/ogg",
            hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        
        let json = """
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
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentAudioLinkDecode() {
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
        
        let object = ActivityContentAudioLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "audio/ogg")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testActivityContentAudioLinkIsNotValid_MissingMediaType() {
        do {
            let object = ActivityContentAudioLink()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingMediaTypeField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsNotValid_MissingHref() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = "audio/ogg"
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHrefField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsNotValid_InvalidHref() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = "audio/ogg"
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsNotValid_NonSupportedHash() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = "audio/ogg"
            object.href = URL(string: "https://www.example.com")
            object.hash = [Hash(algorithm: "invalid", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.hashesDoNotContainSupportedAlgorithm {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsValid() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = "audio/ogg"
            object.href = URL(string: "https://www.example.com")
            object.hash = [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
