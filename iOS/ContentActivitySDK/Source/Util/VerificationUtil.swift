//
//  VerificationUtil.swift
//  ContentActivitySDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class VerificationUtil {
    
    static func isValid(dsnpUserUri: Any?) -> Bool {
        guard let dsnpUserUri = dsnpUserUri as? String
        else {
            return false
        }

        return dsnpUserUri.range(of: #"^dsnp:\/\/[1-9][0-9]{0,19}$"#, options: .regularExpression) != nil
    }
    
    static func isValid(href: Any?) -> Bool {
        guard let href = href as? String
        else {
            return false
        }

        return href.range(of: #"^https?:\/\/.+"#, options: .regularExpression) != nil
    }

    static func isValid(published: Any?) -> Bool {
        guard let published = published as? String
        else {
            return false
        }

        return published.range(of: #"^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d{1,})?(Z|[+-][01][0-9]:[0-5][0-9])?$"#, options: .regularExpression) != nil
    }
    
    static func isValid(duration: Any?) -> Bool {
        guard let duration = duration as? String
        else {
            return false
        }

        return duration.range(of: #"^-?P(([0-9]+Y)?([0-9]+M)?([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+(\.[0-9]+)?S)?)?)$"#, options: .regularExpression) != nil
    }

}
