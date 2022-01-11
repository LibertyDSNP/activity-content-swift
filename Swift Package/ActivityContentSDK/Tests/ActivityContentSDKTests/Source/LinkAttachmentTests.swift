//
//  LinkAttachmentTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/10/22.
//

import XCTest
@testable import ActivityContentSDK

class LinkAttachmentTests: XCTestCase {

    func testLinkAttachmentEncode() {
        let object = LinkAttachment(href: URL(string: "http://www.example.com")!, name: "Link Attachment")
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "name" : "Link Attachment",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testLinkAttachmentDecode() {
        let json = """
            {
              "href" : "http://www.example.com",
              "name" : "Link Attachment",
              "type" : "Link"
            }
            """
        
        let object = LinkAttachment(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.name, "Link Attachment")
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "http://www.example.com")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testLinkAttachmentIsNotValid_MissingHref() {
        do {
            let object = LinkAttachment()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingHrefField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testLinkAttachmentIsNotValid_InvalidHref() {
        do {
            let object = LinkAttachment()
            object.href = URL(string: "invalid://example.com")
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testLinkAttachmentIsValid() {
        do {
            let object = LinkAttachment()
            object.href = URL(string: "http://www.example.com")!
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
