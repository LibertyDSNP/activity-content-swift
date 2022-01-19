//
//  ActivityContentProfile.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class ActivityContentProfile: ActivityContentItem {
    
    /**
     JSON-LD @context
     
     - Requires: MUST be set to https://www.w3.org/ns/activitystreams
     */
    public private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Profile
     */
    public private(set) var type: String = "Profile"
    
    /**
     The display name for the note
     */
    public internal(set) var name: String?
    
    /**
     An array of avatars of the profile
     
     - Requires: MUST be an Image Link AND MUST have at least one supported image MIME type
     */
    public internal(set) var icon: [ActivityContentImageLink]? = []
    
    /**
     Used as a plain text biography of the profile
     */
    public internal(set) var summary: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    public internal(set) var published: Date?
    
    /**
     For location
     
     - Requires: MUST follow ActivityContentLocation Type
     */
    public internal(set) var location: ActivityContentLocation?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public internal(set) var tag: [ActivityContentBaseTag]? = []
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case context = "@context"
        case type,
             name,
             icon,
             summary,
             published,
             location,
             tag
    }
    
    internal required init() {
        super.init()
    }
    
    internal init(name: String? = nil,
                  icon: [ActivityContentImageLink]? = nil,
                  summary: String? = nil,
                  published: Date? = nil,
                  location: ActivityContentLocation? = nil,
                  tag: [ActivityContentBaseTag]? = nil) {
        self.name = name
        self.icon = icon
        self.summary = summary
        self.published = published
        self.location = location
        self.tag = tag
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decode(String.self, forKey: .context)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try? container.decode(String.self, forKey: .name)
        self.icon = try? container.decode([ActivityContentImageLink].self, forKey: .icon)
        self.summary = try? container.decode(String.self, forKey: .summary)
        
        if let formattedDate = try? container.decode(String.self, forKey: .published) {
            /// Convert published date from ISO 8601 string to date object.
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            self.published = formatter.date(from: formattedDate)
        }
        
        self.location = try? container.decode(ActivityContentLocation.self, forKey: .location)
        
        /// Tags array is heterogeneous, and so must be parsed based on tag type.
        let tagArray = try? container.decode(ActivityContentTagsArray.self, forKey: .tag)
        self.tag = tagArray?.tags
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.context, forKey: .context)
        try container.encode(self.type, forKey: .type)
        if let name = self.name {
            try container.encode(name, forKey: .name)
        }
        if self.icon?.isEmpty == false {
            try container.encode(self.icon, forKey: .icon)
        }
        if let summary = self.summary {
            try container.encode(summary, forKey: .summary)
        }
        if let published = self.published {
            /// Encode published date as ISO 8601 string.
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            let formattedDate = formatter.string(from: published)
            try container.encode(formattedDate, forKey: .published)
        }
        if let location = self.location {
            try container.encode(location, forKey: .location)
        }
        if self.tag?.isEmpty == false {
            try container.encode(self.tag, forKey: .tag)
        }
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.context != "https://www.w3.org/ns/activitystreams" {
            throw ActivityContentError.invalidContext
        }
        
        if self.type != "Profile" {
            throw ActivityContentError.invalidType
        }
        
        if !(self.icon?.isEmpty ?? true) {
            if ValidationUtil.hasAtLeastOneSupportedImageMediaType(links: self.icon) == false {
                throw ActivityContentError.linksDoNotContainSupportedFormat
            }
        }
        
        try self.icon?.forEach({ try $0.isValid() })
        try self.tag?.forEach({ try $0.isValid() })
        try self.location?.isValid()
        
        return try super.isValid()
    }
}
