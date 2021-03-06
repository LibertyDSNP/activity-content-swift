//
//  ValidationUtil.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class ValidationUtil {
    
    // MARK: Regex Validators
    
    static private let kDsnpUserUriRegex = #"^dsnp:\/\/[1-9][0-9]{0,19}$"#
    static private let kHrefRegex = #"^https?:\/\/.+"#
    static private let kISO8601Regex = #"^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{1,})?(Z|[+-][01][0-9]:[0-5][0-9])?$"#
    static private let kDurationRegex = #"^-?P(([0-9]+Y)?([0-9]+M)?([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+(\.[0-9]+)?S)?)?)$"#
    static private let kHashRegex = #"^0x[0-9A-Fa-f]{64}$"#
    
    static func isValid(dsnpUserUri: Any?) -> Bool {
        return self.matches(regex: kDsnpUserUriRegex, value: dsnpUserUri)
    }
    
    static func isValid(href: Any?) -> Bool {
        
        var value = href
        if let url = href as? URL {
            value = url.absoluteString
        }
        
        return self.matches(regex: kHrefRegex, value: value)
    }
    
    static func isValid(date: Any?) -> Bool {
        
        var value = date
        if let date = date as? Date {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions.insert(.withFractionalSeconds)
            value = formatter.string(from: date)
        }
        
        return self.matches(regex: kISO8601Regex, value: value)
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
    
    // MARK: "Has at Least One" Validators
    // Activity Content Arrays typically require that at least one item
    // in array has supported type. These methods check these requirements.
    
    static func hasAtLeastOneSupportedAudioMediaType(links: [ActivityContentAudioLink]?) -> Bool {
        for link in links ?? [] {
            if let mediaType = link.mediaType {
                switch mediaType {
                case .custom(_):
                    continue
                default:
                    return true
                }
            }
        }
        
        return false
    }
    
    static func hasAtLeastOneSupportedImageMediaType(links: [ActivityContentImageLink]?) -> Bool {
        for link in links ?? [] {
            if let mediaType = link.mediaType {
                switch mediaType {
                case .custom(_):
                    continue
                default:
                    return true
                }
            }
        }
        
        return false
    }
    
    static func hasAtLeastOneSupportedVideoMediaType(links: [ActivityContentVideoLink]?) -> Bool {
        for link in links ?? [] {
            if let mediaType = link.mediaType {
                switch mediaType {
                case .custom(_):
                    continue
                default:
                    return true
                }
            }
        }
        
        return false
    }

    static func hasAtLeastOneSupportedHashAlgorithm(hashes: [ActivityContentHash]?) -> Bool {
        for hash in hashes ?? [] {
            if let algorithm = hash.algorithm {
                switch algorithm {
                case .custom(_):
                    continue
                default:
                    return true
                }
            }
        }
        
        return false
    }
}
