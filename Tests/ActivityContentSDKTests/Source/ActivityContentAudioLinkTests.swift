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
            mediaType: .ogg,
            hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        
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
        XCTAssertEqual(object?.mediaType, .ogg)
        XCTAssertEqual(object?.hash?.first?.algorithm, .keccak)
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
    
    func testActivityContentAudioLinkIsNotValid_NonSupportedHash() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = .ogg
            object.hash = [ActivityContentHash(algorithm: .custom(algorithm: "invalid"), value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.hashesDoNotContainSupportedAlgorithm {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsNotValid_MissingHref() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = .ogg
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
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
            object.mediaType = .ogg
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentAudioLinkIsValid() {
        do {
            let object = ActivityContentAudioLink()
            object.mediaType = .ogg
            object.href = URL(string: "https://www.example.com")
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testAudioMediaTypes() {
        let mpeg = ActivityContentAudioLink.AudioMediaType(string: "audio/mpeg")
        let ogg = ActivityContentAudioLink.AudioMediaType(string: "audio/ogg")
        let webm = ActivityContentAudioLink.AudioMediaType(string: "audio/webm")
        let custom = ActivityContentAudioLink.AudioMediaType(string: "audio/custom")
        XCTAssertEqual(mpeg?.stringValue, "audio/mpeg")
        XCTAssertEqual(ogg?.stringValue, "audio/ogg")
        XCTAssertEqual(webm?.stringValue, "audio/webm")
        XCTAssertEqual(custom?.stringValue, "audio/custom")
    }
}
