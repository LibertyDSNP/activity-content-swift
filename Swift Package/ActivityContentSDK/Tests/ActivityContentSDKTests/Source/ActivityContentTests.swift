//
//  ActivityContentTests.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentTests: XCTestCase {
    
    func testBuildHashtag() {
        let object = try? ActivityContent.Builders.Tags.Hashtag()
            .setName("#hashtag")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.name, "#hashtag")
        XCTAssertEqual(object?.additionalFields?["custom"] as? Bool, true)
    }
    
    func testBuildMention() {
        let object = try? ActivityContent.Builders.Tags.Mention()
            .setName("Mention Name")
            .setDSNPUserId("dsnp://1234")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
        XCTAssertEqual(object?.additionalFields?["custom"] as? Bool, true)
    }
    
    func testBuildAudioAttachment() {
        let object = try? ActivityContent.Builders.Attachments.Audio()
            .setName("Audio Attachment")
            .addAudioLinks([
                try! ActivityContent.Builders.Attachments.AudioLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("audio/ogg")
                    .addHashes([
                        try! ActivityContent.Builders.Hash()
                            .setAlgorithm("keccak")
                            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .addDuration(180)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.name, "Audio Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "audio/ogg")
        XCTAssertEqual(object?.additionalFields?["custom"] as? Bool, true)
    }
    
    func testBuildAudioLink() {
        let object = try? ActivityContent.Builders.Attachments.AudioLink()
            .setHref(URL(string: "https://www.example.com")!)
            .setMediaType("audio/ogg")
            .addHashes([
                try! ActivityContent.Builders.Hash()
                    .setAlgorithm("keccak")
                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.mediaType, "audio/ogg")
        XCTAssertEqual(object?.additionalFields?["custom"] as? Bool, true)
    }
    
}
