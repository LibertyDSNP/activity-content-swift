//
//  Factory.swift
//  ContentActivitySDK
//
//  Created by Rigo Carbajal on 12/22/21.
//

import Foundation

public typealias DSNPUserId = String

// ---------------------------------

struct Note: Codable {
    public private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    public private(set) var type: String = "Note"
    public var content: String
    public var mediaType: String
    public var name: String?
    public var published: Date?
    
    // Array of attached links or media - how can we enforce this
    // HC: ImageAttachment
    public var attachment: [ImageAttachment]?
    
    // Array of Hashtags or Mentions
    // HC: Hashtag
    public var tag: [Hashtag]?
    public var location: Location?
}

struct Profile: Codable {
    public private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    public private(set) var type: String = "Profile"
    public var name: String?
    public var icon: [ImageLink]?
    public var summary: String?
    public var published: Date?
    public var location: Location?
    
    // Array of Hashtags or Mentions
    // HC: Hashtag
    public var tag: [Hashtag]?
}

// ---------------------------------

protocol Tag {
}

struct Hashtag: Tag, Codable {
    public var name: String
}

struct Mention: Tag {
    public var name: String?
    public private(set) var type: String = "Mention"
    public var id: DSNPUserId
}

// ---------------------------------

enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

struct Location: Codable {
    public private(set) var type: String = "Place"
    public var name: String
    public var accuracy: Float?
    public var altitude: Float?
    public var latitude: Float?
    public var longitude: Float?
    public var radius: Float?
    public var units: LocationUnits?
}

// ---------------------------------

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

// ---------------------------------

struct Hash: Codable {
    public var algorithm: String
    public var value: String
}

// ---------------------------------





class ContentActivityFactory {
    
    static public func createNote(content: String?) {}
    
    func createNew() {
    }
    
}
