//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class Note:  ActivityContentItem {
    
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
    public internal(set) var content: String?
    
    /**
     MIME type for the content field
     
     - Requires: MUST be set to a supported MIME type
     */
    public private(set) var mediaType: String = "text/plain"
    
    /**
     The display name for the note
     */
    public internal(set) var name: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    public internal(set) var published: Date?
    
    /**
     Array of attached links or media
     
     - Requires: MUST be one of the Supported Attachments
     */
    public internal(set) var attachment: [BaseAttachment]? = []
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public internal(set) var tag: [BaseTag]? = []
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    public internal(set) var location: Location?
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case context = "@context"
        case type,
             content,
             mediaType,
             name,
             published,
             attachment,
             tag,
             location
    }
    
    internal override init() {
        super.init()
    }
    
    internal init(content: String,
                  name: String? = nil,
                  published: Date? = nil,
                  attachment: [BaseAttachment]? = nil,
                  tag: [BaseTag]? = nil,
                  location: Location? = nil) {
        self.content = content
        self.name = name
        self.published = published
        self.attachment = attachment
        self.tag = tag
        self.location = location
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decode(String.self, forKey: .context)
        self.type = try container.decode(String.self, forKey: .type)
        self.content = try? container.decode(String.self, forKey: .content)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.name = try? container.decode(String.self, forKey: .name)

        if let formattedDate = try? container.decode(String.self, forKey: .published) {
            /// Convert published date from ISO 8601 string to date object.
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            self.published = formatter.date(from: formattedDate)
        }
        
        /// Attachments array is heterogeneous, and so must be parsed based on tag type.
        let attachmentsArray = try? container.decode(AttachmentsArray.self, forKey: .attachment)
        self.attachment = attachmentsArray?.attachments
        
        /// Tags array is heterogeneous, and so must be parsed based on tag type.
        let tagArray = try? container.decode(TagArray.self, forKey: .tag)
        self.tag = tagArray?.tags
        
        self.location = try? container.decode(Location.self, forKey: .location)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.context, forKey: .context)
        try container.encode(self.type, forKey: .type)
        if let content = self.content {
            try container.encode(content, forKey: .content)
        }
        try container.encode(self.mediaType, forKey: .mediaType)
        if let name = self.name {
            try container.encode(name, forKey: .name)
        }
        if let published = self.published {
            /// Encode published date as ISO 8601 string.
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            let formattedDate = formatter.string(from: published)
            try container.encode(formattedDate, forKey: .published)
        }
        if self.attachment?.isEmpty == false {
            try container.encode(self.attachment, forKey: .attachment)
        }
        if self.tag?.isEmpty == false {
            try container.encode(self.tag, forKey: .tag)
        }
        if let location = self.location {
            try container.encode(location, forKey: .location)
        }
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.content == nil {
            throw ActivityContentError.missingContentField
        }
        
        return true
    }
}
