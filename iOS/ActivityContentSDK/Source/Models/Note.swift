//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Note: Codable {
    
    /**
     JSON-LD @context
     
     - Requires: MUST be set to https://www.w3.org/ns/activitystreams
     */
    public private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Note
     */
    public private(set) var type: String = "Note"
    
    /**
     Text content of the note
     */
    public var content: String
    
    /**
     MIME type for the content field
     
     - Requires: MUST be set to a supported MIME type
     */
    public var mediaType: String
    
    /**
     The display name for the note
     */
    public var name: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    public var published: Date?
    
    /**
     Array of attached links or media
     
     - Requires: MUST be one of the Supported Attachments
     */
    public var attachment: [ImageAttachment]?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public var tag: [Hashtag]?
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    public var location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, content, mediaType, name, published, attachment, tag, location
    }
    
    init(content: String,
         mediaType: String,
         name: String?,
         published: Date?,
         attachment: [ImageAttachment]?,
         tag: [Hashtag]?,
         location: Location?) {
        self.content = content
        self.mediaType = mediaType
        self.name = name
        self.published = published
        self.attachment = attachment
        self.tag = tag
        self.location = location
    }
}
