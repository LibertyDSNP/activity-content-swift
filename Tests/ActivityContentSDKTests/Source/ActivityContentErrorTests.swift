//
//  ActivityContentErrorTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/11/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentErrorTests: XCTestCase {
    
    func testErrorDescriptions() {
        XCTAssertEqual(ActivityContentError.missingContentField.description,
                       "ActivityContentSDK: Note: `content` is required.")
        XCTAssertEqual(ActivityContentError.missingMediaTypeField.description,
                       "ActivityContentSDK: Link: `mediaType` is required.")
        XCTAssertEqual(ActivityContentError.missingAlgorithmField.description,
                       "ActivityContentSDK: Hash: `algorithm` is required.")
        XCTAssertEqual(ActivityContentError.missingHashValueField.description,
                       "ActivityContentSDK: Hash: `value` is required.")
        XCTAssertEqual(ActivityContentError.missingHashtagNameField.description,
                       "ActivityContentSDK: Hashtag: `name` is required.")
        XCTAssertEqual(ActivityContentError.missingLocationNameField.description,
                       "ActivityContentSDK: Location: `name` is required.")
        XCTAssertEqual(ActivityContentError.missingHrefField.description,
                       "ActivityContentSDK: Link: `href` is required.")
        XCTAssertEqual(ActivityContentError.missingUnitsField.description,
                       "ActivityContentSDK: Location: `units` is required.")
        XCTAssertEqual(ActivityContentError.missingDsnpUserUriField.description,
                       "ActivityContentSDK: Mention: `id` is required.")
        XCTAssertEqual(ActivityContentError.invalidHref.description,
                       "ActivityContentSDK: `href` must be supported format. Refer to https://spec.dsnp.org/ActivityContent/Overview#supported-url-schema for supported schema.")
        XCTAssertEqual(ActivityContentError.invalidDsnpUserUri.description,
                       "ActivityContentSDK: `id` must be supported format. Refer to https://spec.dsnp.org/Identifiers#dsnp-user-uri for supported format.")
        XCTAssertEqual(ActivityContentError.invalidHash.description,
                       "ActivityContentSDK: `value` must be supported format. Refer to https://spec.dsnp.org/Identifiers#dsnp-content-hash for supported format.")
        XCTAssertEqual(ActivityContentError.invalidType.description,
                       "ActivityContentSDK: `type` is not expected value. Verify that you are using the correct Builder for the expected type.")
        XCTAssertEqual(ActivityContentError.invalidContext.description,
                       "ActivityContentSDK: `context` is not expected value. Must be set to \"https://www.w3.org/ns/activitystreams\".")
        XCTAssertEqual(ActivityContentError.invalidMediaType.description,
                       "ActivityContentSDK: `mediaType` is not expected value. Media type for notes must be set to \"text/plain\".")
        XCTAssertEqual(ActivityContentError.linksDoNotContainSupportedFormat.description,
                       "ActivityContentSDK: Attachment media arrays must contain at least one entry with a supported mime type. For example, an Audio Attachment must contain at least one media item with a mediaType of either \"audio/mpeg\", \"audio/ogg\", or \"audio/webm\".")
        XCTAssertEqual(ActivityContentError.hashesDoNotContainSupportedAlgorithm.description,
                       "ActivityContentSDK: Hash arrays must contain at least one entry with a keccak hash.")
    }
}
