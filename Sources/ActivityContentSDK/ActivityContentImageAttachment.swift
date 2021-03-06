//
//  ActivityContentImageAttachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentImageAttachment: ActivityContentBaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Image
     */
    public private(set) var type: String = "Image"
    
    /**
     An array of links for given image content in different formats
     
     - Requires: MUST be an Image Link AND MUST have at least one supported image MIME type
     */
    public internal(set) var url: [ActivityContentImageLink]? = []
    
    /**
     The display name or alt text for the image
     */
    public internal(set) var name: String?
    
    internal required init() {
        super.init()
    }
    
    internal init(url: [ActivityContentImageLink],
                  name: String? = nil) {
        self.url = url
        self.name = name
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case url
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try? container.decode([ActivityContentImageLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.type != "Image" {
            throw ActivityContentError.invalidType
        }
        
        if ValidationUtil.hasAtLeastOneSupportedImageMediaType(links: self.url) == false {
            throw ActivityContentError.linksDoNotContainSupportedFormat
        }
        
        try self.url?.forEach({ try $0.isValid() })
        
        return try super.isValid()
    }
}
