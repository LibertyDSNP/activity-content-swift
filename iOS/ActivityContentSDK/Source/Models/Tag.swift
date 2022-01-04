//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Tags: Codable {
    
    enum TagsTypeKey: CodingKey {
        case type
    }
    
    enum TagTypes: String, Decodable {
        case mention = "Mention"
    }
    
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
