//
//  ContentActivitySDKTests.swift
//  ContentActivitySDKTests
//
//  Created by Rigo Carbajal on 12/22/21.
//

import XCTest
@testable import ContentActivitySDK

class ContentActivitySDKTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPrintNote() {
        let note = Note(content: "This is a note",
                        mediaType: "text/plain",
                        name: "Sample Name",
                        published: .now,
                        attachment: [
                            ImageAttachment(url: [ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: "0x1234")], height: 400, width: 400)], name: "ImageLink Name")],
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
    
    
    
    private func json<T: Encodable>(object: T) -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(object)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
    
}
