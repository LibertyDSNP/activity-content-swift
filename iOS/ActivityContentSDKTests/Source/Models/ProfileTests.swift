//
//  ProfileTests.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/4/22.
//

import XCTest
@testable import ActivityContentSDK

class ProfileTests: XCTestCase {
    
    func testProfileEncodePartial() {
        let profile = Profile()
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "type" : "Profile"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: profile), json)
    }
    
    func testProfileEncodeFull() {
        let profile = Profile(name: "Profile Name",
                              icon: [ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)], height: 400, width: 400)],
                              summary: "Profile Summary",
                              published: Date(timeIntervalSince1970: 1640321788.6924329),
                              location: Location(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm),
                              tag: [Hashtag(name: "#hashtag"), Mention(name: "Mention Name", id: "dsnp://user")])
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "icon" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "keecak",
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
                "latitude" : 123.23000335693359,
                "longitude" : -45.234001159667969,
                "name" : "Location Name",
                "radius" : 100,
                "type" : "Place",
                "units" : "cm"
              },
              "name" : "Profile Name",
              "published" : 662014588.69243288,
              "summary" : "Profile Summary",
              "tag" : [
                {
                  "name" : "#hashtag"
                },
                {
                  "id" : "dsnp:\\/\\/user",
                  "name" : "Mention Name",
                  "type" : "Mention"
                }
              ],
              "type" : "Profile"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: profile), json)
    }
    
    func testProfileDecode() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "icon" : [
                {
                  "hash" : [
                    {
                      "algorithm" : "keecak",
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
              "published" : 662014588.69243288,
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
        
        let object = TestUtil.object(with: Profile.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.name, "Profile Name")
        XCTAssertEqual(object?.icon?.count, 1)
        XCTAssertEqual(object?.icon?[0].mediaType, "image/png")
        XCTAssertEqual(object?.summary, "Profile Summary")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? Hashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? Mention)?.id, "dsnp://user")
        XCTAssertEqual(object?.type, "Profile")
    }
}