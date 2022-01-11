//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class Note:  ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    
    /**
     JSON-LD @context
     
     - Requires: MUST be set to https://www.w3.org/ns/activitystreams
     */
    internal private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Note
     */
    internal private(set) var type: String = "Note"
    
    /**
     Text content of the note
     */
    internal var content: String?
    
    /**
     MIME type for the content field
     
     - Requires: MUST be set to a supported MIME type
     */
    internal private(set) var mediaType: String = "text/plain"
    
    /**
     The display name for the note
     */
    internal var name: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    internal var published: Date?
    
    /**
     Array of attached links or media
     
     - Requires: MUST be one of the Supported Attachments
     */
    internal var attachment: [BaseAttachment]? = []
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    internal var tag: [BaseTag]? = []
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    internal private(set) var location: Location?
    
    internal var storedJson: String?
    
    private enum CodingKeys: String, CodingKey {
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
    
    internal init() {}
    
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
    }
    
    public func encode(to encoder: Encoder) throws {
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
        
        if let published = published {
            if ValidationUtil.isValid(date: published) == false {
                throw ActivityContentError.invalidDate
            }
        }
        
        return true
    }
}
