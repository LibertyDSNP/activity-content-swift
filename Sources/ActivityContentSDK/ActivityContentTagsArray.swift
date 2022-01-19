//
//  ActivityContentTagsArray.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

class ActivityContentTagsArray: ActivityContentFromJson {
    
    internal let tags: [ActivityContentBaseTag]?
    
    enum TagsTypeKey: CodingKey {
        case type
    }
    
    enum TagTypes: String, Decodable {
        case mention = "Mention"
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var tags: [ActivityContentBaseTag] = []
        var tagsArray = container
        while (!container.isAtEnd) {
            let tag = try container.nestedContainer(keyedBy: TagsTypeKey.self)
            let type = try tag.decodeIfPresent(TagTypes.self, forKey: TagsTypeKey.type)
            switch type {
            case .mention:
                tags.append(try tagsArray.decode(ActivityContentMention.self))
            case .none:
                /// ActivityContentHashtags do not specify a "type" value
                tags.append(try tagsArray.decode(ActivityContentHashtag.self))
            }
        }
        
        self.tags = tags.isEmpty ? nil : tags
    }
}
