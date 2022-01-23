//
//  ActivityContentProfileTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/4/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentProfileTests: XCTestCase {
    
    func testActivityContentProfileEncodePartial() {
        let object = ActivityContentProfile()
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "type" : "Profile"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentProfileEncodeFull() {
        let object = ActivityContentProfile(name: "Profile Name",
                                            icon: [ActivityContentImageLink(href: URL(string: "http://www.example.com")!, mediaType: .png, hash: [ActivityContentHash(keccakHashWithString: "Lorem Ipsum")], height: 400, width: 400)],
                                            summary: "Profile Summary",
                                            published: Date(timeIntervalSince1970: 1640321788.6924329),
                                            location: ActivityContentLocation(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm),
                                            tag: [ActivityContentHashtag(name: "#hashtag"), ActivityContentMention(name: "Mention Name", id: "dsnp://1234")])
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "icon" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "keccak",
                      "value" : "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345"
                    }
                  ],
                  "height" : 400,
                  "href" : "http:\\/\\/www.example.com",
                  "mediaType" : "image\\/png",
                  "type" : "Link",
                  "width" : 400
                }
              ],
              "location" : {
                "accuracy" : 50,
                "altitude" : 25,
                "latitude" : 123.23,
                "longitude" : -45.234000000000002,
                "name" : "Location Name",
                "radius" : 100,
                "type" : "Place",
                "units" : "cm"
              },
              "name" : "Profile Name",
              "published" : "2021-12-24T04:56:28.692Z",
              "summary" : "Profile Summary",
              "tag" : [
                {
                  "name" : "#hashtag"
                },
                {
                  "id" : "dsnp:\\/\\/1234",
                  "name" : "Mention Name",
                  "type" : "Mention"
                }
              ],
              "type" : "Profile"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentProfileDecode() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "icon" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "keccak",
                      "value" : "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345"
                    }
                  ],
                  "height" : 400,
                  "href" : "http://www.example.com",
                  "mediaType" : "image/png",
                  "type" : "Link",
                  "width" : 400
                }
              ],
              "location" : {
                "accuracy" : 50,
                "altitude" : 25,
                "latitude" : 123.23000335693359,
                "longitude" : -45.234001159667969,
                "name" : "Location Name",
                "radius" : 100,
                "type" : "Place",
                "units" : "cm"
              },
              "name" : "Profile Name",
              "published" : "2021-12-24T04:56:28.692Z",
              "summary" : "Profile Summary",
              "tag" : [
                {
                  "name" : "#hashtag"
                },
                {
                  "id" : "dsnp://user",
                  "name" : "Mention Name",
                  "type" : "Mention"
                }
              ],
              "type" : "Profile"
            }
            """
        
        let object = ActivityContentProfile(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.name, "Profile Name")
        XCTAssertEqual(object?.icon?.count, 1)
        XCTAssertEqual(object?.icon?[0].mediaType, .png)
        XCTAssertEqual(object?.summary, "Profile Summary")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.692)
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://user")
        XCTAssertEqual(object?.type, "Profile")
    }
    
    func testActivityContentProfileIsNotValid_InvalidContext() {
        let json = """
            {
              "@context" : "Invalid",
              "name" : "Profile Name",
              "summary" : "Profile Summary",
              "type" : "Profile"
            }
            """
        
        let object = ActivityContentProfile(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidContext)
        }
    }
    
    func testActivityContentProfileIsNotValid_InvalidType() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "name" : "Profile Name",
              "summary" : "Profile Summary",
              "type" : "Invalid"
            }
            """
        
        let object = ActivityContentProfile(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidType)
        }
    }
    
    func testActivityContentProfileIsNotValid_NonSupportedIconFormat() {
        do {
            let object = ActivityContentProfile()
            let link = ActivityContentImageLink(
                href: URL(string: "http://www.example.com")!,
                mediaType: .custom(mediaType: "image/unsupported"),
                hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
            object.icon = [link]
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.linksDoNotContainSupportedFormat)
        }
    }
    
    func testActivityContentProfileIsValid() {
        let object = ActivityContentProfile()
        let link = ActivityContentImageLink(
            href: URL(string: "http://www.example.com")!,
            mediaType: .png,
            hash: [ActivityContentHash(algorithm: .keccak, value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")])
        object.icon = [link]
        XCTAssertTrue(try! object.isValid())
    }
}
