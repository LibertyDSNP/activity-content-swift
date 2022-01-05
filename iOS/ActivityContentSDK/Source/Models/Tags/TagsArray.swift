//
//  TagsArray.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class TagArray: Codable {
    
    let tags: [BaseTag]?
    
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
                tags.append(try tagsArray.decode(Hashtag.self))
            }
        }
        
        self.tags = tags.isEmpty ? nil : tags
    }
}
