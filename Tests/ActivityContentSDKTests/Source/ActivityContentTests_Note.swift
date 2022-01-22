//
//  ActivityContentTests_Note.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK
import CoreLocation

class ActivityContentTests_Note: XCTestCase {
    
    func testBuildWithParams() {
        let hash = try? ActivityContent.Builders.Hash()
            .withAlgorithm(.keccak)
            .withValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
            .build()
        let imageLink = try? ActivityContent.Builders.Attachments.ImageLink()
            .withHref(URL(string: "http://www.example.com/image.png")!)
            .withMediaType(.png)
            .addHashes([hash!])
            .build()
        let imageAttachment = try? ActivityContent.Builders.Attachments.Image()
            .withName("Image Name")
            .addImageLinks([imageLink!])
            .build()
        let hashtag = try? ActivityContent.Builders.Tags.Hashtag()
            .withName("#hashtag")
            .build()
        let mention = try? ActivityContent.Builders.Tags.Mention()
            .withName("Mention Name")
            .withDSNPUserId("dsnp://1234")
            .build()
        let location = try? ActivityContent.Builders.Location()
            .withName("Location Name")
            .withAccuracy(50)
            .withAltitude(100)
            .withCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
            .withRadius(25)
            .withUnits(.cm)
            .build()
    
        let object = try? ActivityContent.Builders.Note()
            .withContent("Note Content")
            .withName("Note Name")
            .withPublished(Date(timeIntervalSince1970: 1640321788.6924329))
            .addAttachments([imageAttachment])
            .addTags([hashtag, mention])
            .withLocation(location)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.attachment?.count, 1)
        XCTAssertEqual((object?.attachment?[0] as? ActivityContentImageAttachment)?.name, "Image Name")
        XCTAssertEqual(object?.content, "Note Content")
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.mediaType, "text/plain")
        XCTAssertEqual(object?.name, "Note Name")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.type, "Note")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Note(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "attachment" : [
                {
                  "name" : "Image Name",
                  "type" : "Image",
                  "url" : [
                    {
                      "hash" : [
                        {
                          "algorithm" : "keccak",
                          "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                        }
                      ],
                      "height" : 400,
                      "href" : "http://www.example.com/image.png",
                      "mediaType" : "image/png",
                      "type" : "Link",
                      "width" : 400
                    }
                  ]
                },
                {
                  "name" : "Link Name",
                  "type" : "Link",
                  "href" : "http://www.example.com"
                },
                {
                 "name" : "Video Name",
                 "type" : "Video",
                 "url" : [
                   {
                     "hash" : [
                       {
                         "algorithm" : "keccak",
                         "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                       }
                     ],
                     "height" : 400,
                     "href" : "http://www.example.com/video.mp4",
                     "mediaType" : "video/mp4",
                     "type" : "Link",
                     "width" : 400
                   }
                 ]
                },
                {
                 "name" : "Audio Name",
                 "type" : "Audio",
                 "url" : [
                   {
                     "hash" : [
                       {
                         "algorithm" : "keccak",
                         "value" : "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7"
                       }
                     ],
                     "href" : "http://www.example.com/audio.ogg",
                     "mediaType" : "audio/ogg",
                     "type" : "Link"
                   }
                 ]
                }
              ],
              "content" : "This is a note",
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
              "mediaType" : "text/plain",
              "name" : "Sample Name",
              "published" : "2021-12-24T04:56:28.692Z",
              "tag" : [
                {
                  "name" : "#hashtag"
                },
                {
                  "name" : "Mention Name",
                  "type" : "Mention",
                  "id" : "dsnp://1234"
                }
            
              ],
              "type" : "Note"
            }
            """
        
        let object = try? ActivityContent.Builders.Note(json: json)?.build()
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.attachment?.count, 4)
        XCTAssertEqual((object?.attachment?[0] as? ActivityContentImageAttachment)?.name, "Image Name")
        XCTAssertEqual((object?.attachment?[1] as? ActivityContentLinkAttachment)?.name, "Link Name")
        XCTAssertEqual((object?.attachment?[2] as? ActivityContentVideoAttachment)?.name, "Video Name")
        XCTAssertEqual((object?.attachment?[3] as? ActivityContentAudioAttachment)?.name, "Audio Name")
        XCTAssertEqual(object?.content, "This is a note")
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.mediaType, "text/plain")
        XCTAssertEqual(object?.name, "Sample Name")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.692)
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.type, "Note")
        XCTAssertTrue(try object?.isValid() ?? false)
    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "mediaType" : "text/plain",
              "name" : "Sample Name",
              "published" : "2021-12-24T04:56:28.692Z",
              "type" : "Note"
            }
            """
        let builder = ActivityContent.Builders.Note(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
