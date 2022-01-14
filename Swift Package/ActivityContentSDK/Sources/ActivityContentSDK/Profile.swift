//
//  Profile.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class Profile: ActivityContentItem {
    
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
     
     - Requires: MUST follow Image Link Type
     */
    public internal(set) var icon: [ImageLink]? = []
    
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
     
     - Requires: MUST follow Location Type
     */
    public internal(set) var location: Location?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public internal(set) var tag: [BaseTag]? = []
    
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
    
    internal override init() {
        super.init()
    }
    
    internal init(name: String? = nil,
                  icon: [ImageLink]? = nil,
                  summary: String? = nil,
                  published: Date? = nil,
                  location: Location? = nil,
                  tag: [BaseTag]? = nil) {
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
        self.icon = try? container.decode([ImageLink].self, forKey: .icon)
        self.summary = try? container.decode(String.self, forKey: .summary)
        
        if let formattedDate = try? container.decode(String.self, forKey: .published) {
            /// Convert published date from ISO 8601 string to date object.
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            self.published = formatter.date(from: formattedDate)
        }
        
        self.location = try? container.decode(Location.self, forKey: .location)
        
        /// Tags array is heterogeneous, and so must be parsed based on tag type.
        let tagArray = try? container.decode(TagArray.self, forKey: .tag)
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
    internal func isValid() throws -> Bool {
        if let published = published {
            if ValidationUtil.isValid(date: published) == false {
                throw ActivityContentError.invalidDate
            }
        }
        
        return true
    }
}
