//
//  ImageLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ImageLinkTests: XCTestCase {

    func testImageLinkEncode() {
        let object = ImageLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "image/png",
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
              "mediaType" : "image\\/png",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testImageLinkDecode() {
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
        
        let object = ImageLink(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "image/png")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testImageLinkIsNotValid_MissingMediaType() {
        do {
            let object = ImageLink()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingMediaTypeField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testImageLinkIsNotValid_MissingHref() {
        do {
            let object = ImageLink()
            object.mediaType = "image/png"
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHrefField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testImageLinkIsNotValid_InvalidHref() {
        do {
            let object = ImageLink()
            object.mediaType = "image/png"
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testImageLinkIsNotValid_NonSupportedHash() {
        do {
            let object = ImageLink()
            object.mediaType = "image/png"
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
    
    func testImageLinkIsValid() {
        do {
            let object = ImageLink()
            object.mediaType = "image/png"
            object.href = URL(string: "https://www.example.com")
            object.hash = [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
