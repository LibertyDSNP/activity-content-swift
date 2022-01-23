//
//  ActivityContentImageLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentImageLinkTests: XCTestCase {
    
    func testActivityContentImageLinkEncode() {
        let object = ActivityContentImageLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .png,
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
              "mediaType" : "image\\/png",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentImageLinkDecode() {
        let json = """
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
            """
        
        let object = ActivityContentImageLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, .png)
        XCTAssertEqual(object?.hash?.first?.algorithm, .keccak)
        XCTAssertTrue(try! object!.isValid())
    }
    
    func testActivityContentImageLinkIsNotValid_MissingMediaType() {
        do {
            let object = ActivityContentImageLink()
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingMediaTypeField)
        }
    }
    
    func testActivityContentImageLinkIsNotValid_NonSupportedHash() {
        do {
            let object = ActivityContentImageLink()
            object.mediaType = .png
            object.hash = [ActivityContentHash(algorithm: .custom(algorithm: "invalid"), value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.hashesDoNotContainSupportedAlgorithm)
        }
    }
    
    func testActivityContentImageLinkIsNotValid_MissingHref() {
        do {
            let object = ActivityContentImageLink()
            object.mediaType = .png
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingHrefField)
        }
    }
    
    func testActivityContentImageLinkIsNotValid_InvalidHref() {
        do {
            let object = ActivityContentImageLink()
            object.mediaType = .png
            object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidHref)
        }
    }
    
    func testActivityContentImageLinkIsValid() {
        let object = ActivityContentImageLink()
        object.mediaType = .png
        object.href = URL(string: "https://www.example.com")
        object.hash = [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
        XCTAssertTrue(try! object.isValid())
    }
    
    func testImageMediaTypes() {
        let jpeg = ActivityContentImageLink.ImageMediaType(string: "image/jpeg")
        let png = ActivityContentImageLink.ImageMediaType(string: "image/png")
        let svg = ActivityContentImageLink.ImageMediaType(string: "image/svg+xml")
        let webp = ActivityContentImageLink.ImageMediaType(string: "image/webp")
        let gif = ActivityContentImageLink.ImageMediaType(string: "image/gif")
        let custom = ActivityContentImageLink.ImageMediaType(string: "image/custom")
        XCTAssertEqual(jpeg?.stringValue, "image/jpeg")
        XCTAssertEqual(png?.stringValue, "image/png")
        XCTAssertEqual(svg?.stringValue, "image/svg+xml")
        XCTAssertEqual(webp?.stringValue, "image/webp")
        XCTAssertEqual(gif?.stringValue, "image/gif")
        XCTAssertEqual(custom?.stringValue, "image/custom")
    }
}
