//
//  ActivityContentTests_Profile.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK
import CoreLocation

class ActivityContentTests_Profile: XCTestCase {
    
    func testBuildWithParams() {
        let hash = try? ActivityContent.Builders.Hash()
            .setAlgorithm("keccak")
            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
            .build()
        let imageLink = try? ActivityContent.Builders.Attachments.ImageLink()
            .setHref(URL(string: "http://www.example.com/image.png")!)
            .setMediaType("image/png")
            .addHashes([hash!])
            .build()
        let hashtag = try? ActivityContent.Builders.Tags.Hashtag()
            .setName("#hashtag")
            .build()
        let mention = try? ActivityContent.Builders.Tags.Mention()
            .setName("Mention Name")
            .setDSNPUserId("dsnp://1234")
            .build()
        let location = try? ActivityContent.Builders.Location()
            .setName("Location Name")
            .setAccuracy(50)
            .setAltitude(100)
            .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
            .setRadius(25)
            .setUnits(.cm)
            .build()
    
        let object = try? ActivityContent.Builders.Profile()
            .setName("Profile Name")
            .addIcons([imageLink!])
            .setSummary("Profile Summary")
            .setPublished(Date(timeIntervalSince1970: 1640321788.6924329))
            .setLocation(location)
            .addTags([hashtag!, mention!])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.name, "Profile Name")
        XCTAssertEqual(object?.icon?.count, 1)
        XCTAssertEqual(object?.icon?[0].mediaType, "image/png")
        XCTAssertEqual(object?.summary, "Profile Summary")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.type, "Profile")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Profile(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "name" : "Profile Name",
              "published" : "2021-12-24T04:56:28.692Z",
              "summary" : "Profile Summary",
              "tag" : [
                {
                  "name" : "#hashtag"
                },
                {
                  "id" : "dsnp://1234",
                  "name" : "Mention Name",
                  "type" : "Mention"
                }
              ],
              "type" : "Profile"
            }
            """
        
        let object = try? ActivityContent.Builders.Profile(json: json)?.build()
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.name, "Profile Name")
        XCTAssertEqual(object?.summary, "Profile Summary")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.692)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.type, "Profile")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "name" : "Profile Name",
              "summary" : "Profile Summary",
              "type" : "Invalid"
            }
            """
        let builder = ActivityContent.Builders.Profile(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
