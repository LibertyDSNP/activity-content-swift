//
//  ImageLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ImageLink: BaseLink {
    
    /**
     MIME type of href content
     */
    internal var mediaType: String?
    
    /**
     Array of hashes for linked content validation
     
     - Requires: MUST include at least one supported hash
     */
    internal var hash: [Hash]? = []
    
    /**
     A hint as to the rendering height in device-independent pixels
     */
    internal var height: Float?
    
    /**
     A hint as to the rendering width in device-independent pixels
     */
    internal var width: Float?
    
    internal override init() {
        super.init()
    }
    
    internal init(href: URL,
                  mediaType: String,
                  hash: [Hash],
                  height: Float? = nil,
                  width: Float? = nil) throws {
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
        try super.init(href: href)
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
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.width, forKey: .width)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.mediaType == nil {
            throw ActivityContentError.missingField
        }
        
        if ValidationUtil.isValid(href: self.href) == false {
            throw ActivityContentError.invalidHref
        }
        
        if ValidationUtil.hasAtLeastOneSupportedHashAlgorithm(hashes: self.hash) == false {
            throw ActivityContentError.hashesDoNotContainSupportedAlgorithm
        }
        
        return true
    }
}
