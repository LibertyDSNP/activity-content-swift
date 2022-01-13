//
//  TagsArray.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

class TagArray: ActivityContentFromJson {
    
    internal let tags: [BaseTag]?
    
    internal var jsonSource: String?
    
    enum TagsTypeKey: CodingKey {
        case type
    }
    
    enum TagTypes: String, Decodable {
        case mention = "Mention"
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var tags: [BaseTag] = []
        var tagsArray = container
        while (!container.isAtEnd) {
            let tag = try container.nestedContainer(keyedBy: TagsTypeKey.self)
            let type = try tag.decodeIfPresent(TagTypes.self, forKey: TagsTypeKey.type)
            switch type {
            case .mention:
                tags.append(try tagsArray.decode(Mention.self))
            case .none:
                /// Hashtags do not specify a "type" value
                tags.append(try tagsArray.decode(Hashtag.self))
            }
        }
        
        self.tags = tags.isEmpty ? nil : tags
    }
}
