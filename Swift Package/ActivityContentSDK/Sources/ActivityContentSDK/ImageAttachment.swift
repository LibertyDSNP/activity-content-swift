//
//  ImageAttachment.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class ImageAttachment: BaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Image
     */
    public private(set) var type: String = "Image"
    
    /**
     An array of links for given image content in different formats
     
     - Requires: MUST be an Image Link AND MUST have at least one supported image MIME type
     */
    public var url: [ImageLink]
    
    /**
     The display name or alt text for the image
     */
    public var name: String?
    
    init(url: [ImageLink],
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
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
    }
}
