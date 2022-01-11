//
//  ActivityContentError.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/6/22.
//

import Foundation

enum ActivityContentError: Error {
    
    // Missing data
    case missingContentField
    case missingMediaTypeField
    case missingAlgorithmField
    case missingHashValueField
    case missingNameField
    case missingHrefField
    case missingUnitsField

    // Invalid data
    case invalidHref
    case invalidDsnpUserUri
    case invalidHash
    case invalidDate

    // Arrays do not contain supported value
    case linksDoNotContainSupportedFormat
    case hashesDoNotContainSupportedAlgorithm
}
