//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class Note: ActivityContentItem {
    
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
    public var content: String?
    
    /**
     MIME type for the content field
     
     - Requires: MUST be set to a supported MIME type
     */
    public private(set) var mediaType: String = "text/plain"
    
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
    public var attachment: [BaseAttachment]? = []
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public var tag: [BaseTag]? = []
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    public private(set) var location: Location?
    
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
    
    init(content: String,
         mediaType: String,
         name: String? = nil,
         published: Date? = nil,
         attachment: [BaseAttachment]? = nil,
         tag: [BaseTag]? = nil,
         location: Location? = nil) {
        self.content = content
        self.mediaType = mediaType
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
        self.content = try container.decode(String.self, forKey: .content)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.name = try? container.decode(String.self, forKey: .name)
        self.published = try? container.decode(Date.self, forKey: .published)
        
        /// Attachments array is heterogeneous, and so must be parsed based on tag type.
        let attachmentsArray = try? container.decode(AttachmentsArray.self, forKey: .attachment)
        self.attachment = attachmentsArray?.attachments
        
        /// Tags array is heterogeneous, and so must be parsed based on tag type.
        let tagArray = try? container.decode(TagArray.self, forKey: .tag)
        self.tag = tagArray?.tags
        
        self.location = try? container.decode(Location.self, forKey: .location)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.content == nil {
            throw ActivityContentError.missingField
        }
        
        if VerificationUtil.isValid(date: self.published) == false {
            throw ActivityContentError.invalidDate
        }
        
        return true
    }
}
