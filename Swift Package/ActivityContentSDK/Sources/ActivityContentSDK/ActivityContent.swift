//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation

public class ActivityContent {
    
    public static func createNote(content: String,
                                  mediaType: String) -> Note? {

        return Note(content: "This is a note",
                        mediaType: "text/plain",
                        name: "Sample Name",
                        published: Date(timeIntervalSince1970: 1640321788.6924329),
                        attachment: [
                            ImageAttachment(url: [ImageLink(href: URL(string: "http://www.example.com")!, mediaType: "image/png", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)], height: 400, width: 400)], name: "Image Name"),
                            VideoAttachment(url: [VideoLink(href: URL(string: "http://www.example.com")!, mediaType: "video/mp4", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)], height: 400, width: 400)], name: "Video Name", duration: 30),
                            AudioAttachment(url: [AudioLink(href: URL(string: "http://www.example.com")!, mediaType: "video/mp4", hash: [Hash(algorithm: "keecak", value: HashUtil.hash(content: "Lorem Ipsum")!)])], name: "Audio Name", duration: 30),
                            LinkAttachment(href: URL(string: "http://www.example.com")!, name: "Link Name")
                        ],
                        tag: [Hashtag(name: "#hashtag"), Mention(name: "Mention Name", id: "dsnp://user")],
                        location: Location(name: "Location Name", accuracy: 50, altitude: 25, latitude: 123.23, longitude: -45.234, radius: 100, units: .cm))
    }
    
}
