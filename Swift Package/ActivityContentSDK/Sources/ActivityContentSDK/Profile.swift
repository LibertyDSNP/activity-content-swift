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
    internal private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Profile
     */
    internal private(set) var type: String = "Profile"
    
    /**
     The display name for the note
     */
    internal var name: String?
    
    /**
     An array of avatars of the profile
     
     - Requires: MUST follow Image Link Type
     */
    internal var icon: [ImageLink]? = []
    
    /**
     Used as a plain text biography of the profile
     */
    internal var summary: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    internal var published: Date?
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    internal var location: Location?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    internal var tag: [BaseTag]? = []
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type,
             name,
             icon,
             summary,
             published,
             location,
             tag
    }
    
    internal init() {}
    
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
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decode(String.self, forKey: .context)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try? container.decode(String.self, forKey: .name)
        self.icon = try? container.decode([ImageLink].self, forKey: .icon)
        self.summary = try? container.decode(String.self, forKey: .summary)
        self.published = try? container.decode(Date.self, forKey: .published)
        self.location = try? container.decode(Location.self, forKey: .location)
        
        /// Tags array is heterogeneous, and so must be parsed based on tag type.
        let tagArray = try? container.decode(TagArray.self, forKey: .tag)
        self.tag = tagArray?.tags
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if VerificationUtil.isValid(date: self.published) == false {
            throw ActivityContentError.invalidDate
        }
        
        return true
    }
}
