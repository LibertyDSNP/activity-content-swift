//
//  AttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class AttachmentTests: XCTestCase {
    
    func testLinkEncode() {
        let link = try? LinkAttachment(href: URL(string: "http://www.example.com")!, name: "Link Name")
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "name" : "Link Name",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: link), json)
    }
    
    func testLinkDecode() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link"
            }
            """
        let object = TestUtil.object(with: LinkAttachment.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
    }
    
    func testVideoLinkEncode() {
        let videoLink = try? VideoLink(href: URL(string: "http://www.example.com")!, mediaType: "video/mp4", hash: [Hash(algorithm: "keecak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")], height: 400, width: 400)
        
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "height" : 400,
              "href" : "http:\\/\\/www.example.com",
              "mediaType" : "video\\/mp4",
              "type" : "Link",
              "width" : 400
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: videoLink), json)
    }
    
    func testVideoLinkDecode() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "height" : 400,
              "href" : "http://www.example.com",
              "mediaType" : "video/mp4",
              "type" : "Link",
              "width" : 300
            }
            """
        let object = TestUtil.object(with: VideoLink.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.height, 400)
        XCTAssertEqual(object?.width, 300)
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "video/mp4")
    }
    
    func testImageLinkEncode() {
        let imageLink = try? ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")], height: 400, width: 400)
        
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "height" : 400,
              "href" : "http:\\/\\/www.example.com",
              "mediaType" : "image\\/png",
              "type" : "Link",
              "width" : 400
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: imageLink), json)
    }
    
    func testImageLinkDecode() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "height" : 400,
              "href" : "http://www.example.com",
              "mediaType" : "image/png",
              "type" : "Link",
              "width" : 300
            }
            """
        let object = TestUtil.object(with: ImageLink.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.height, 400)
        XCTAssertEqual(object?.width, 300)
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "image/png")
    }
    
    func testAudioLinkEncode() {
        let audioLink = try? AudioLink(href: URL(string: "http://www.example.com")!, mediaType: "audio/mp3", hash: [Hash(algorithm: "keecak", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "href" : "http:\\/\\/www.example.com",
              "mediaType" : "audio\\/mp3",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: audioLink), json)
    }
    
    func testAudioLinkDecode() {
        let json = """
            {
              "hash" : [
                {
                  "algorithm" : "keecak",
                  "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                }
              ],
              "href" : "http://www.example.com",
              "mediaType" : "audio/mp3",
              "type" : "Link"
            }
            """
        let object = TestUtil.object(with: AudioLink.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
        XCTAssertEqual(object?.mediaType, "audio/mp3")
    }
}
