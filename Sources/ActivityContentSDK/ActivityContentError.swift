//
//  ActivityContentError.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/6/22.
//

import Foundation

public enum ActivityContentError: Error {
    
    // Missing data
    case missingContentField
    case missingMediaTypeField
    case missingAlgorithmField
    case missingHashValueField
    case missingNameField
    case missingHrefField
    case missingUnitsField
    case missingDsnpUserUriField

    // Invalid data
    case invalidHref
    case invalidDsnpUserUri
    case invalidHash
    case invalidDate
    case invalidType
    case invalidContext
    case invalidMediaType

    // Arrays do not contain supported value
    case linksDoNotContainSupportedFormat
    case hashesDoNotContainSupportedAlgorithm
}
