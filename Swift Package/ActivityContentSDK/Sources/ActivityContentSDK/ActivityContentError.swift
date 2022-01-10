//
//  ActivityContentError.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/6/22.
//

import Foundation

enum ActivityContentError: Error {
    case invalidHref
    case invalidDsnpUserUri
    case invalidHash
    case invalidDate
    case linksDoNotContainSupportedFormat
    case hashesDoNotContainSupportedAlgorithm
    case missingField
}
