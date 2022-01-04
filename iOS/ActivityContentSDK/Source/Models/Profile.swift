//
//  Profile.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Profile: Codable {
    
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
    public var name: String?
    
    /**
     An array of avatars of the profile
    
     - Requires: MUST follow Image Link Type
     */
    public var icon: [ImageLink]?
    
    /**
     Used as a plain text biography of the profile
     */
    public var summary: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    public var published: Date?
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    public var location: Location?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public var tag: [Tag]?
    
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
}
