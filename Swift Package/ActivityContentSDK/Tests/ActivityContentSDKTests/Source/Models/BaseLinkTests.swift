//
//  BaseLinkTests.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/6/22.
//

import XCTest
@testable import ActivityContentSDK

class BaseLinkTests: XCTestCase {

    func testBaseLinkInitWithInvalidHref() {
        do {
            _ = try BaseLink(href: URL(string: "invalid://www.example.com")!)
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testImageLinkInitWithInvalidHref() {
        do {
            _ = try ImageLink(href: URL(string: "invalid://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "algo", value: "0x1234")])
            XCTFail()
        } catch ActivityContentError.invalidHref {
            XCTAssert(true)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseLinkEncode() {
        let baseLink = try? BaseLink(href: URL(string: "http://www.example.com")!)
        
        let json = """
            {
              "href" : "http:\\/\\/www.example.com",
              "type" : "Link"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: baseLink), json)
    }
    
    func testBaseLinkDecode() {
        let json = """
            {
              "href" : "http://www.example.com",
              "type" : "Link"
            }
            """
        let object = TestUtil.object(with: BaseLink.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href.absoluteString, "http://www.example.com")
    }
}
