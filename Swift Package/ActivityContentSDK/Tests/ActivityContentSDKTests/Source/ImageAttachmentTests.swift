//
//  ImageAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class ImageAttachmentTests: XCTestCase {

    func testImageAttachmentEncode() {
        let link = ImageLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: "image/png",
            hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        let object = ImageAttachment(url: [link], name: "Image Attachment")
        
        let json = """
            {
              "name" : "Image Attachment",
              "type" : "Image",
              "url" : [
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
              ]
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testImageAttachmentDecode() {
        let json = """
            {
              "name" : "Image Attachment",
              "type" : "Image",
              "url" : [
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
              ]
            }
            """
        
        let object = ImageAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Image")
        XCTAssertEqual(object?.name, "Image Attachment")
        XCTAssertEqual(object?.url?.first?.mediaType, "image/png")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testImageAttachmentIsNotValid_NonSupportedImageFormat() {
        do {
            let object = ImageAttachment()
            let link = ImageLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "image/unsupported",
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
    
    func testImageAttachmentIsValid() {
        do {
            let object = ImageAttachment()
            let link = ImageLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: "image/png",
                hash: [Hash(algorithm: "keccak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.url = [link]
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
