//
//  VerificationUtil.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class VerificationUtil {
    
    static private let kDsnpUserUriRegex = #"^dsnp:\/\/[1-9][0-9]{0,19}$"#
    static private let kHrefRegex = #"^https?:\/\/.+"#
    static private let kISO8601Regex = #"^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{1,})?(Z|[+-][01][0-9]:[0-5][0-9])?$"#
    static private let kDurationRegex = #"^-?P(([0-9]+Y)?([0-9]+M)?([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+(\.[0-9]+)?S)?)?)$"#
    static private let kHashRegex = #"^0x[0-9A-Fa-f]{64}$"#
    
    static private let kSupportedHashAlgorithms = ["keccak"]
    static private let kSupportedAudioMediaTypes = ["audio/mpeg", "audio/ogg", "audio/webm"]
    static private let kSupportedImageMediaTypes = [
        "image/jpeg",
        "image/png",
        "image/svg+xml",
        "image/webp",
        "image/gif",
    ]
    static private let kSupportedVideoMediaTypes = [
        "video/mpeg",
        "video/ogg",
        "video/webm",
        "video/H256",
        "video/mp4",
    ]
    
    static func isValid(dsnpUserUri: Any?) -> Bool {
        return self.matches(regex: kDsnpUserUriRegex, value: dsnpUserUri)
    }
    
    static func isValid(href: Any?) -> Bool {
        return self.matches(regex: kHrefRegex, value: href)
    }
    
    static func isValid(published: Any?) -> Bool {
        return self.matches(regex: kISO8601Regex, value: published)
    }
    
    static func isValid(duration: Any?) -> Bool {
        return self.matches(regex: kDurationRegex, value: duration)
    }
    
    static func isValid(hash: Any?) -> Bool {
        return self.matches(regex: kHashRegex, value: hash)
    }
    
    private static func matches(regex: String, value: Any?) -> Bool {
        guard let value = value as? String
        else {
            return false
        }
        
        return value.range(of: regex, options: .regularExpression) != nil
    }
    
    // ------
    
    static func hasAtLeastOneSupportedAudioMediaType(links: [AudioLink]?) -> Bool {
        for link in links ?? [] {
            if self.kSupportedAudioMediaTypes.contains(link.mediaType) {
                return true
            }
        }
        
        return false
    }
    
    static func hasAtLeastOneSupportedImageMediaType(links: [ImageLink]?) -> Bool {
        for link in links ?? [] {
            if self.kSupportedImageMediaTypes.contains(link.mediaType) {
                return true
            }
        }
        
        return false
    }
    
    static func hasAtLeastOneSupportedVideoMediaType(links: [VideoLink]?) -> Bool {
        for link in links ?? [] {
            if self.kSupportedVideoMediaTypes.contains(link.mediaType) {
                return true
            }
        }
        
        return false
    }
    
    static func hasAtLeastOneSupportedHashAlgorithm(hashes: [Hash]?) -> Bool {
        for hash in hashes ?? [] {
            if self.kSupportedHashAlgorithms.contains(hash.algorithm) &&
                self.isValid(hash: hash) {
                return true
            }
        }
        
        return false
    }
    
}
