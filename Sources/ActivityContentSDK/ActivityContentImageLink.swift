//
//  ActivityContentImageLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentImageLink: ActivityContentBaseLink {
    
    /**
     MIME type of href content
     */
    public internal(set) var mediaType: ImageMediaType?
    public enum ImageMediaType: Codable, Equatable {
        case jpeg
        case png
        case svg_xml
        case webp
        case gif
        case custom(mediaType: String)
        
        init?(string: String?) {
            guard let string = string else { return nil }
            switch string {
            case "image/jpeg":
                self = .jpeg
            case "image/png":
                self = .png
            case "image/svg+xml":
                self = .svg_xml
            case "image/webp":
                self = .webp
            case "image/gif":
                self = .gif
            default:
                self = .custom(mediaType: string)
            }
        }
        
        var stringValue: String {
            switch self {
            case .jpeg:
                return "image/jpeg"
            case .png:
                return "image/png"
            case .svg_xml:
                return "image/svg+xml"
            case .webp:
                return "image/webp"
            case .gif:
                return "image/gif"
            case .custom(let mediaType):
                return mediaType
            }
        }
    }
    
    /**
     Array of hashes for linked content validation
     
     - Requires: MUST include at least one supported hash
     */
    public internal(set) var hash: [ActivityContentHash]? = []
    
    /**
     A hint as to the rendering height in device-independent pixels
     */
    public internal(set) var height: Float?
    
    /**
     A hint as to the rendering width in device-independent pixels
     */
    public internal(set) var width: Float?
    
    internal required init() {
        super.init()
    }
    
    internal init(href: URL,
                  mediaType: ImageMediaType,
                  hash: [ActivityContentHash],
                  height: Float? = nil,
                  width: Float? = nil) {
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
        super.init(href: href)
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case mediaType
        case hash
        case height
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Convert mediaType string to enum
        let mediaTypeString = try? container.decode(String.self, forKey: .mediaType)
        self.mediaType = ImageMediaType(string: mediaTypeString)
        
        self.hash = try? container.decode([ActivityContentHash].self, forKey: .hash)
        self.height = try? container.decode(Float.self, forKey: .height)
        self.width = try? container.decode(Float.self, forKey: .width)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let mediaType = self.mediaType {
            try container.encode(mediaType.stringValue, forKey: .mediaType)
        }
        try container.encode(self.hash, forKey: .hash)
        if let height = self.height {
            try container.encode(height, forKey: .height)
        }
        if let width = self.width {
            try container.encode(width, forKey: .width)
        }
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.mediaType == nil {
            throw ActivityContentError.missingMediaTypeField
        }
        
        if ValidationUtil.hasAtLeastOneSupportedHashAlgorithm(hashes: self.hash) == false {
            throw ActivityContentError.hashesDoNotContainSupportedAlgorithm
        }
        
        try self.hash?.forEach({ try $0.isValid() })
        
        return try super.isValid()
    }
}
