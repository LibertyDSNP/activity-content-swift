//
//  ActivityContentVideoLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/13/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentVideoLinkTests: XCTestCase {

    func testActivityContentVideoLinkEncode() {
        let object = ActivityContentVideoLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .H265,
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
              "mediaType" : "video\\/H265",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentVideoLinkDecode() {
        let json = """
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
            """
        
        let object = ActivityContentVideoLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, .H265)
        XCTAssertEqual(object?.hash?.first?.algorithm, .keccak)
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testActivityContentVideoLinkIsNotValid_MissingMediaType() {
        do {
            let object = ActivityContentVideoLink()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingMediaTypeField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentVideoLinkIsNotValid_NonSupportedHash() {
        do {
            let object = ActivityContentVideoLink()
            object.mediaType = .H265
            object.href = URL(string: "https://www.example.com")
            object.hash = [ActivityContentHash(algorithm: .custom(algorithm: "unsupported"), value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.hashesDoNotContainSupportedAlgorithm {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentVideoLinkIsNotValid_MissingHref() {
        do {
            let object = ActivityContentVideoLink()
            object.mediaType = .H265
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHrefField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testActivityContentVideoLinkIsNotValid_InvalidHref() {
        do {
            let object = ActivityContentVideoLink()
            object.mediaType = .H265
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
    
    func testActivityContentVideoLinkIsValid() {
        do {
            let object = ActivityContentVideoLink()
            object.mediaType = .H265
            object.href = URL(string: "https://www.example.com")
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testVideoMediaTypes() {
        let mpeg = ActivityContentVideoLink.VideoMediaType(string: "video/mpeg")
        let ogg = ActivityContentVideoLink.VideoMediaType(string: "video/ogg")
        let webm = ActivityContentVideoLink.VideoMediaType(string: "video/webm")
        let H265 = ActivityContentVideoLink.VideoMediaType(string: "video/H265")
        let mp4 = ActivityContentVideoLink.VideoMediaType(string: "video/mp4")
        let custom = ActivityContentVideoLink.VideoMediaType(string: "video/custom")
        XCTAssertEqual(mpeg?.stringValue, "video/mpeg")
        XCTAssertEqual(ogg?.stringValue, "video/ogg")
        XCTAssertEqual(webm?.stringValue, "video/webm")
        XCTAssertEqual(H265?.stringValue, "video/H265")
        XCTAssertEqual(mp4?.stringValue, "video/mp4")
        XCTAssertEqual(custom?.stringValue, "video/custom")
    }
}
