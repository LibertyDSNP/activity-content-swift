//
//  NoteTests.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/3/22.
//

import XCTest
@testable import ActivityContentSDK

class NoteTests: XCTestCase {
    
    func testNoteEncodePartial() {
        let note = Note(content: "This is a note",
                        mediaType: "text/plain",
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
        
        XCTAssertEqual(TestUtil.json(object: note), json)
    }
    
    func testNoteEncodeull() {
        let note = Note(content: "This is a note",
                        mediaType: "text/plain",
                        name: "Sample Name",
                        published: Date(timeIntervalSince1970: 1640321788.6924329),
                        attachment: [
                            ImageAttachment(url: [ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)], height: 400, width: 400)], name: "ImageLink Name")],
                        tag: [Hashtag(name: "#hashtag")],
                        location: Location(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm))
        
        let json = """
            {
              "@context" : "https:\\/\\/www.w3.org\\/ns\\/activitystreams",
              "attachment" : [
                {
                  "name" : "ImageLink Name",
                  "type" : "Image",
                  "url" : [
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
              "mediaType" : "text\\/plain",
              "name" : "Sample Name",
              "published" : 662014588.69243288,
              "tag" : [
                {
                  "name" : "#hashtag"
                }
              ],
              "type" : "Note"
            }
            """
        
        XCTAssertEqual(TestUtil.json(object: note), json)
    }
    
    func testNoteDecode() {
        let json = """
            {
              "@context" : "https://www.w3.org/ns/activitystreams",
              "attachment" : [
                {
                  "name" : "ImageLink Name",
                  "type" : "Image",
                  "url" : [
                    {
                      "hash" : [
                        {
                          "algorithm" : "keecak",
                          "value" : "0x1234"
                        }
                      ],
                      "height" : 400,
                      "href" : "http://www.example.com",
                      "mediaType" : "image/png",
                      "type" : "Link",
                      "width" : 400
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
              "published" : 662014588.692433,
              "tag" : [
                {
                  "name" : "#hashtag"
                }
              ],
              "type" : "Note"
            }
            """
        
        let object = TestUtil.object(with: Note.self, json: json)
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.attachment?.count, 1)
        XCTAssertEqual(object?.attachment?.first?.name, "ImageLink Name")
        XCTAssertEqual(object?.content, "This is a note")
        XCTAssertNotNil(object?.location)
        XCTAssertEqual(object?.location?.accuracy, 50)
        XCTAssertEqual(object?.mediaType, "text/plain")
        XCTAssertEqual(object?.name, "Sample Name")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertEqual(object?.tag?.count, 1)
        XCTAssertEqual(object?.tag?.first?.name, "#hashtag")
        XCTAssertEqual(object?.type, "Note")
    }
}
