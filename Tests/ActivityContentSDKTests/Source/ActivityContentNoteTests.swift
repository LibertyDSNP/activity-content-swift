//
//  ActivityContentNoteTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentNoteTests: XCTestCase {
    
    func testActivityContentNoteEncodePartial() {
        let object = ActivityContentNote(content: "This is a note",
                          name: nil,
                          published: nil,
                          attachment: nil,
                          tag: nil,
                          location: nil)
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "content" : "This is a note",
              "mediaType" : "text\\/plain",
              "type" : "Note"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentNoteEncodeFull() {
        let object = ActivityContentNote(content: "This is a note",
                          name: "Sample Name",
                          published: Date(timeIntervalSince1970: 1640321788.6924329),
                          attachment: [
                            ActivityContentImageAttachment(url: [ActivityContentImageLink(href: URL(string: "http://www.example.com")!, mediaType: .png, hash: [ActivityContentHash(keccakHashWithString: "Lorem Ipsum")], height: 400, width: 400)], name: "Image Name"),
                            ActivityContentVideoAttachment(url: [ActivityContentVideoLink(href: URL(string: "http://www.example.com")!, mediaType: .mp4, hash: [ActivityContentHash(keccakHashWithString: "Lorem Ipsum")], height: 400, width: 400)], name: "Video Name", duration: 30),
                            ActivityContentAudioAttachment(url: [ActivityContentAudioLink(href: URL(string: "http://www.example.com")!, mediaType: .ogg, hash: [ActivityContentHash(keccakHashWithString: "Lorem Ipsum")])], name: "Audio Name", duration: 30),
                            ActivityContentLinkAttachment(href: URL(string: "http://www.example.com")!, name: "Link Name")
                          ],
                          tag: [ActivityContentHashtag(name: "#hashtag"), ActivityContentMention(name: "Mention Name", id: "dsnp://1234")],
                          location: ActivityContentLocation(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm))
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "attachment" : [
                {
                  "name" : "Image Name",
                  "type" : "Image",
                  "url" : [
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
                  ]
                },
                {
                  "duration" : 30,
                  "name" : "Video Name",
                  "type" : "Video",
                  "url" : [
                    {
                      "hash" : [
                        {
                          "algorithm" : "keccak",
                          "value" : "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345"
                        }
                      ],
                      "height" : 400,
                      "href" : "http:\\/\\/www.example.com",
                      "mediaType" : "video\\/mp4",
                      "type" : "Link",
                      "width" : 400
                    }
                  ]
                },
                {
                  "duration" : 30,
                  "name" : "Audio Name",
                  "type" : "Audio",
                  "url" : [
                    {
                      "hash" : [
                        {
                          "algorithm" : "keccak",
                          "value" : "0x1735d6988f7bd80965929051eacb1e6a0a1b65151eaba85f42e20b5aecbde345"
                        }
                      ],
                      "href" : "http:\\/\\/www.example.com",
                      "mediaType" : "audio\\/ogg",
                      "type" : "Link"
                    }
                  ]
                },
                {
                  "href" : "http:\\/\\/www.example.com",
                  "name" : "Link Name",
                  "type" : "Link"
                }
              ],
              "content" : "This is a note",
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
              "mediaType" : "text\\/plain",
              "name" : "Sample Name",
              "published" : "2021-12-24T04:56:28.692Z",
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
              "type" : "Note"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentNoteDecode() {
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
                     "href" : "http://www.example.com/audio.mp3",
                     "mediaType" : "audio/mp3",
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
                  "id" : "dsnp://user"
                }
            
              ],
              "type" : "Note"
            }
            """
        
        let object = ActivityContentNote(json: json)
        XCTAssertNotNil(object)
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
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://user")
        XCTAssertEqual(object?.type, "Note")
    }
    
    func testActivityContentNoteDecodeWhenAttachmentIsUnknown() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "attachment" : [
                {
                  "name" : "Unknown Name",
                  "type" : "Unknown",
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
                }
              ],
              "mediaType" : "text/plain",
              "type" : "Note"
            }
            """
        
        let object = ActivityContentNote(json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertNil(object?.attachment)
        XCTAssertEqual(object?.type, "Note")
    }
    
    func testActivityContentNoteIsNotValid_InvalidContext() {
        let json = """
            {
              "@context" : "Invalid",
              "content" : "This is a note",
              "mediaType" : "text/plain",
              "type" : "Note"
            }
            """
        
        let object = ActivityContentNote(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidContext)
        }
    }
    
    func testActivityContentNoteIsNotValid_InvalidType() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "content" : "This is a note",
              "mediaType" : "text/plain",
              "type" : "Invalid"
            }
            """
        
        let object = ActivityContentNote(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidType)
        }
    }
    
    func testActivityContentNoteIsNotValid_InvalidMediaType() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "content" : "This is a note",
              "mediaType" : "text/invalid",
              "type" : "Note"
            }
            """
        
        let object = ActivityContentNote(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidMediaType)
        }
    }
    
    func testActivityContentNoteIsNotValid_MissingContent() {
        do {
            let object = ActivityContentNote()
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingContentField)
        }
    }
    
    func testActivityContentNoteIsValid() {
        let object = ActivityContentNote()
        object.content = "Hello World"
        XCTAssertTrue(try! object.isValid())
    }
}
