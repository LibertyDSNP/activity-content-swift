//
//  Profile.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

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
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, name, icon, summary, published, location, tag
    }
}
