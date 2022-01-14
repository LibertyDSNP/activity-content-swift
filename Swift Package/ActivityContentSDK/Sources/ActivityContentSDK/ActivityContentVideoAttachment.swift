//
//  ActivityContentVideoAttachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentVideoAttachment: BaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Video
     */
    public private(set) var type: String = "Video"
    
    /**
     An array of links for given image content in different formats
     
     - Requires: MUST be a Video Link AND MUST have at least one supported video MIME type
     */
    public internal(set) var url: [ActivityContentVideoLink]? = []
    
    /**
     The display name for the video
     */
    public internal(set) var name: String?
    
    /**
     Approximate duration of the video
     */
    public internal(set) var duration: TimeInterval?
    
    internal override init() {
        super.init()
    }
    
    internal init(url: [ActivityContentVideoLink],
                  name: String? = nil,
                  duration: TimeInterval? = nil) {
        self.url = url
        self.name = name
        self.duration = duration
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case url
        case name
        case duration
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([ActivityContentVideoLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        self.duration = try? container.decode(TimeInterval.self, forKey: .duration)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.duration, forKey: .duration)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if ValidationUtil.hasAtLeastOneSupportedVideoMediaType(links: self.url) == false {
            throw ActivityContentError.linksDoNotContainSupportedFormat
        }
        
        return true
    }
}
