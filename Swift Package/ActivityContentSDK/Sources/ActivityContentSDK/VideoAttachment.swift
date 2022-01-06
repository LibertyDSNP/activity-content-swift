//
//  VideoAttachment.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

public class VideoAttachment: BaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Video
     */
    public private(set) var type: String = "Video"

    /**
     An array of links for given image content in different formats
     
     - Requires: MUST be a Video Link AND MUST have at least one supported video MIME type
     */
    public var url: [VideoLink]
    
    /**
     The display name for the video
     */
    public var name: String?
    
    /**
     Approximate duration of the video
     */
    public var duration: TimeInterval?
    
    init(url: [VideoLink],
         name: String? = nil,
         duration: TimeInterval? = nil) {
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
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.duration, forKey: .duration)
    }
}
