//
//  ActivityContentAudioLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentAudioLink: ActivityContentBaseLink {
    
    /**
     MIME type of href content
     */
    public internal(set) var mediaType: String?
    
    /**
     Array of hashes for linked content validation
     
     - Requires: MUST include at least one supported hash
     */
    public internal(set) var hash: [ActivityContentHash]? = []
    
    internal override init() {
        super.init()
    }
    
    internal init(href: URL,
                  mediaType: String,
                  hash: [ActivityContentHash]) {
        self.mediaType = mediaType
        self.hash = hash
        super.init(href: href)
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case mediaType
        case hash
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([ActivityContentHash].self, forKey: .hash)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.mediaType == nil {
            throw ActivityContentError.missingMediaTypeField
        }
        
        if self.href == nil {
            throw ActivityContentError.missingHrefField
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