//
//  Attachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

struct AudioAttachment: Codable {
    public private(set) var type: String = "Audio"
    public var url: [AudioLink]
    public var name: String?
    public var duration: TimeInterval?
}

struct AudioLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
}

// ---

struct ImageAttachment: Codable {
    public private(set) var type: String = "Image"
    public var url: [ImageLink]
    public var name: String?
}

struct ImageLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
}

// ---

struct VideoAttachment: Codable {
    public private(set) var type: String = "Video"
    public var url: [VideoLink]
    public var name: String?
    public var duration: TimeInterval?
}

struct VideoLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
}

// ---

struct Link: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var name: String?
}
