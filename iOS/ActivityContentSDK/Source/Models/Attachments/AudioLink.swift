//
//  AudioLink.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class AudioLink: BaseLink {
    public var mediaType: String
    public var hash: [Hash]
    
    init(href: URL,
         mediaType: String,
         hash: [Hash]) {
        self.mediaType = mediaType
        self.hash = hash
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case mediaType
        case hash
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([Hash].self, forKey: .hash)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
    }
}
