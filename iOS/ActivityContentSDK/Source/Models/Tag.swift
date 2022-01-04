//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Tags: Codable {
    
    let tags: [Tag]
    
    private enum TagsKeys: String, CodingKey { case tag }
    
    enum TagsTypeKey: CodingKey {
        case type
    }
    
    enum TagTypes: String, Decodable {
        case mention = "Mention"
    }
    
    static public func parse(container: UnkeyedDecodingContainer) throws -> [Tag]? {
        var tagsArrayForType = container
        var tags = [Tag]()
        var tagsArray = tagsArrayForType
        while(!tagsArrayForType.isAtEnd) {
            let tag = try tagsArrayForType.nestedContainer(keyedBy: TagsTypeKey.self)
            let type = try tag.decodeIfPresent(TagTypes.self, forKey: TagsTypeKey.type)
            switch type {
            case .mention:
                print("found mention")
                tags.append(try tagsArray.decode(Mention.self))
            case .none:
                print("found hashtag")
                tags.append(try tagsArray.decode(Hashtag.self))
            }
        }
        return tags.isEmpty ? nil : tags
    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: TagsKeys.self)
//        var tagsArrayForType = try container.nestedUnkeyedContainer(forKey: .tag)
//        var tags = [Tag]()
//        var tagsArray = tagsArrayForType
//        while(!tagsArrayForType.isAtEnd) {
//            let tag = try tagsArrayForType.nestedContainer(keyedBy: TagsTypeKey.self)
//            let type = try tag.decodeIfPresent(TagTypes.self, forKey: TagsTypeKey.type)
//            switch type {
//            case .mention:
//                print("found mention")
//                tags.append(try tagsArray.decode(Mention.self))
//            case .none:
//                print("found hashtag")
//                tags.append(try tagsArray.decode(Hashtag.self))
//            }
//        }
//
//        self.tags = tags
//    }
}

class Tag: Codable {
}

class Hashtag: Tag {
    public var name: String
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey { case name }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.name = try container.decode(String.self, forKey: .name)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

class Mention: Tag {
    public var name: String?
    public private(set) var type: String = "Mention"
    public var id: DSNPUserId
    
    init(name: String?,
         id: DSNPUserId) {
        self.name = name
        self.id = id
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey { case name, type, id }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.id = try container.decode(DSNPUserId.self, forKey: .id)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.id, forKey: .id)
    }
}
