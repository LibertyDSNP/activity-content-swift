//
//  VerificationUtil.swift
//  ContentActivitySDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class VerificationUtil {
    
    static private let kDsnpUserUriRegex = #"^dsnp:\/\/[1-9][0-9]{0,19}$"#
    static private let kHrefRegex = #"^https?:\/\/.+"#
    static private let kISO8601Regex = #"^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{1,})?(Z|[+-][01][0-9]:[0-5][0-9])?$"#
    static private let kDurationRegex = #"^-?P(([0-9]+Y)?([0-9]+M)?([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+(\.[0-9]+)?S)?)?)$"#
    
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
    
    private static func matches(regex: String, value: Any?) -> Bool {
        guard let value = value as? String
        else {
            return false
        }
        
        return value.range(of: regex, options: .regularExpression) != nil
    }
}
