//
//  ActivityContentVideoLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentVideoLink: ActivityContentBaseLink {
    
    /**
     MIME type of href content
     */
    public internal(set) var mediaType: VideoMediaType?
    public enum VideoMediaType: Codable, Equatable {
        case mpeg
        case ogg
        case webm
        case H265
        case mp4
        case custom(mediaType: String)
        
        init?(string: String?) {
            guard let string = string else { return nil }
            switch string {
            case "video/mpeg":
                self = .mpeg
            case "video/ogg":
                self = .ogg
            case "video/webm":
                self = .webm
            case "video/H265":
                self = .H265
            case "video/mp4":
                self = .mp4
            default:
                self = .custom(mediaType: string)
            }
        }
        
        var stringValue: String {
            switch self {
            case .mpeg:
                return "video/mpeg"
            case .ogg:
                return "video/ogg"
            case .webm:
                return "video/webm"
            case .H265:
                return "video/H265"
            case .mp4:
                return "video/mp4"
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
                  mediaType: VideoMediaType,
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
        self.mediaType = VideoMediaType(string: mediaTypeString)
        
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
