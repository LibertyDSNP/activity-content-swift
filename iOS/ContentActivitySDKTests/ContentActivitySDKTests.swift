//
//  ContentActivitySDKTests.swift
//  ContentActivitySDKTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ContentActivitySDK

class ContentActivitySDKTests: XCTestCase {

    
    func testHash() {
        let hash = HashUtil.hash(content: "Lorem ipsum")
        XCTAssertEqual(hash, "0x4a63a2902ad43de8c568bb4a8acbe12e95e8fbfb3babf985ea871e9fccf2dadb")
        
        let nilHash = HashUtil.hash(content: nil)
        XCTAssertNil(nilHash)
    }
    
    

    func testPrintNote() {
        let note = Note(content: "This is a note",
                        mediaType: "text/plain",
                        name: "Sample Name",
                        published: .now,
                        attachment: [
                            ImageAttachment(url: [ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)], height: 400, width: 400)], name: "ImageLink Name")],
                        tag: [Hashtag(name: "#hashtag")],
                        location: Location(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm))
        print(self.json(object: note)!)
    }
    
    func testPrintImageLink() {
        let imageLink = ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: "0x1234")], height: 400, width: 400)
        print(self.json(object: imageLink)!)
    }
    
    func testPrintHash() {
        let hash = Hash(algorithm: "keecak", value: "0x1234")
        print(self.json(object: hash)!)
    }
    
    
    
    
    func testInitFromJSON_Note() {
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
        let object = object(with: Note.self, json: json)
        print(object!)
    }
    
    func testInitFromJSON_Hash() {
        let json = """
{
  "algorithm" : "keecak",
  "value" : "0x1234"
}
"""
        let object = object(with: Hash.self, json: json)
        print(object!)
    }
    
    func testInitFromJSON_ImageLink() {
        let json = """
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
"""
        let object = object(with: ImageLink.self, json: json)
        print(object!)
    }
    

    
    private func json<T: Encodable>(object: T) -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let jsonData = try encoder.encode(object)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
    
    private func object<T: Decodable>(with: T.Type, json: String) -> T? {
        do {
            let decoder = JSONDecoder()
            let root = try decoder.decode(T.self, from: Data(json.utf8))
            return root
        } catch {
            print(error)
            return nil
        }
    }
}
