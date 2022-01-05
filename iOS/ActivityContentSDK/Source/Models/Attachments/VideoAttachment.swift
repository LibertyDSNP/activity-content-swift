//
//  VideoAttachment.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class VideoAttachment: BaseAttachment {
    public private(set) var type: String = "Video"
    public var url: [VideoLink]
    public var name: String?
    public var duration: TimeInterval?
    
    init(url: [VideoLink],
         name: String?,
         duration: TimeInterval?) {
        self.url = url
        self.name = name
        self.duration = duration
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case url
        case name
        case duration
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([VideoLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        self.duration = try? container.decode(TimeInterval.self, forKey: .duration)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.duration, forKey: .duration)
    }
}
