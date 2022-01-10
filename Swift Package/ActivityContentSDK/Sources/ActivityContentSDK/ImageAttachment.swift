//
//  ImageAttachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ImageAttachment: BaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Image
     */
    internal private(set) var type: String = "Image"
    
    /**
     An array of links for given image content in different formats
     
     - Requires: MUST be an Image Link AND MUST have at least one supported image MIME type
     */
    internal var url: [ImageLink]? = []
    
    /**
     The display name or alt text for the image
     */
    internal var name: String?
    
    internal override init() {
        super.init()
    }
    
    internal init(url: [ImageLink],
                  name: String? = nil) {
        self.url = url
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case url
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([ImageLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: superdecoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if VerificationUtil.hasAtLeastOneSupportedImageMediaType(links: self.url) == false {
            throw ActivityContentError.linksDoNotContainSupportedFormat
        }
        
        return true
    }
}
