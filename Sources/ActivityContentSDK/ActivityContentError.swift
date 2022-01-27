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
    case missingHashtagNameField
    case missingLocationNameField
    case missingHrefField
    case missingUnitsField
    case missingDsnpUserUriField

    // Invalid data
    case invalidHref
    case invalidDsnpUserUri
    case invalidHash
    case invalidType
    case invalidContext
    case invalidMediaType

    // Arrays do not contain supported value
    case linksDoNotContainSupportedFormat
    case hashesDoNotContainSupportedAlgorithm
}

extension ActivityContentError: CustomStringConvertible {
    
    public var description: String {
        
        // Let's try and provide some more context around the error.
        let description: String
        
        switch self {
        case .missingContentField:
            description = "Note: `content` is required."
        case .missingMediaTypeField:
            description = "Link: `mediaType` is required."
        case .missingAlgorithmField:
            description = "Hash: `algorithm` is required."
        case .missingHashValueField:
            description = "Hash: `value` is required."
        case .missingHashtagNameField:
            description = "Hashtag: `name` is required."
        case .missingLocationNameField:
            description = "Location: `name` is required."
        case .missingHrefField:
            description = "Link: `href` is required."
        case .missingUnitsField:
            description = "Location: `units` is required."
        case .missingDsnpUserUriField:
            description = "Mention: `id` is required."
        case .invalidHref:
            description = "`href` must be supported format. Refer to https://spec.dsnp.org/ActivityContent/Overview#supported-url-schema for supported schema."
        case .invalidDsnpUserUri:
            description = "`id` must be supported format. Refer to https://spec.dsnp.org/Identifiers#dsnp-user-uri for supported format."
        case .invalidHash:
            description = "`value` must be supported format. Refer to https://spec.dsnp.org/Identifiers#dsnp-content-hash for supported format."
        case .invalidType:
            description = "`type` is not expected value. Verify that you are using the correct Builder for the expected type."
        case .invalidContext:
            description = "`context` is not expected value. Must be set to \"https://www.w3.org/ns/activitystreams\"."
        case .invalidMediaType:
            description = "`mediaType` is not expected value. Media type for notes must be set to \"text/plain\"."
        case .linksDoNotContainSupportedFormat:
            description = "Attachment media arrays must contain at least one entry with a supported mime type. For example, an Audio Attachment must contain at least one media item with a mediaType of either \"audio/mpeg\", \"audio/ogg\", or \"audio/webm\"."
        case .hashesDoNotContainSupportedAlgorithm:
            description = "Hash arrays must contain at least one entry with a keccak hash."
        }
        
        let prefix = "ActivityContentSDK:"
        return prefix + " " + description
    }
}
