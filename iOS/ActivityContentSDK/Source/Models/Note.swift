//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

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
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, content, mediaType, name, published, attachment, tag, location
    }
}
