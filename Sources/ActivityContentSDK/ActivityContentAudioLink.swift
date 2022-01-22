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
    public internal(set) var mediaType: AudioMediaType?
    public enum AudioMediaType: Codable, Equatable {
        case mpeg
        case ogg
        case webm
        case custom(mediaType: String)
        
        init?(string: String?) {
            guard let string = string else { return nil }
            switch string {
            case "audio/mpeg":
                self = .mpeg
            case "audio/ogg":
                self = .ogg
            case "audio/webm":
                self = .webm
            default:
                self = .custom(mediaType: string)
            }
        }
        
        var stringValue: String {
            switch self {
            case .mpeg:
                return "audio/mpeg"
            case .ogg:
                return "audio/ogg"
            case .webm:
                return "audio/webm"
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
    
    internal required init() {
        super.init()
    }
    
    internal init(href: URL,
                  mediaType: AudioMediaType,
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
        
        // Convert mediaType string to enum
        let mediaTypeString = try? container.decode(String.self, forKey: .mediaType)
        self.mediaType = AudioMediaType(string: mediaTypeString)
        
        self.hash = try? container.decode([ActivityContentHash].self, forKey: .hash)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let mediaType = self.mediaType {
            try container.encode(mediaType.stringValue, forKey: .mediaType)
        }
        try container.encode(self.hash, forKey: .hash)
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
