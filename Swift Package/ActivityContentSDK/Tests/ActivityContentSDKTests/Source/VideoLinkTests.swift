//
//  VideoLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/13/22.
//

import XCTest
@testable import ActivityContentSDK

class VideoLinkTests: XCTestCase {

    func testVideoLinkEncode() {
        let object = VideoLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "video/H265",
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
              "mediaType" : "video\\/H265",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testVideoLinkDecode() {
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
        
        let object = VideoLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "video/H265")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testVideoLinkIsNotValid_MissingMediaType() {
        do {
            let object = VideoLink()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingMediaTypeField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testVideoLinkIsNotValid_MissingHref() {
        do {
            let object = VideoLink()
            object.mediaType = "video/H265"
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHrefField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testVideoLinkIsNotValid_InvalidHref() {
        do {
            let object = VideoLink()
            object.mediaType = "video/H265"
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testVideoLinkIsNotValid_NonSupportedHash() {
        do {
            let object = VideoLink()
            object.mediaType = "video/H265"
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
    
    func testVideoLinkIsValid() {
        do {
            let object = VideoLink()
            object.mediaType = "video/H265"
            object.href = URL(string: "https://www.example.com")
            object.hash = [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
