//
//  VideoLink.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class VideoLink: BaseLink {
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
    
    init(href: URL,
         mediaType: String,
         hash: [Hash],
         height: Float?,
         width: Float?) {
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case mediaType
        case hash
        case height
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([Hash].self, forKey: .hash)
        self.height = try container.decode(Float.self, forKey: .height)
        self.width = try container.decode(Float.self, forKey: .width)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.width, forKey: .width)
    }
}
