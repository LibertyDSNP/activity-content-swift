//
//  ActivityContentTests.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK
import CoreLocation

class ActivityContentTests: XCTestCase {
    
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
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.mediaType, "audio/ogg")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildImageAttachment() {
        let object = try? ActivityContent.Builders.Attachments.Image()
            .setName("Image Attachment")
            .addImageLinks([
                try! ActivityContent.Builders.Attachments.ImageLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("image/png")
                    .addHashes([
                        try! ActivityContent.Builders.Hash()
                            .setAlgorithm("keccak")
                            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Image")
        XCTAssertEqual(object?.name, "Image Attachment")
        XCTAssertEqual(object?.url?.first?.mediaType, "image/png")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildImageLink() {
        let object = try? ActivityContent.Builders.Attachments.ImageLink()
            .setHref(URL(string: "https://www.example.com")!)
            .setMediaType("image/png")
            .setSize(CGSize(width: 320, height: 480))
            .addHashes([
                try! ActivityContent.Builders.Hash()
                    .setAlgorithm("keccak")
                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.mediaType, "image/png")
        XCTAssertEqual(object?.width, 320)
        XCTAssertEqual(object?.height, 480)
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildVideoAttachment() {
        let object = try? ActivityContent.Builders.Attachments.Video()
            .setName("Video Attachment")
            .addVideoLinks([
                try! ActivityContent.Builders.Attachments.VideoLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("video/H265")
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
        
        XCTAssertEqual(object?.type, "Video")
        XCTAssertEqual(object?.name, "Video Attachment")
        XCTAssertEqual(object?.duration, 180)
        XCTAssertEqual(object?.url?.first?.mediaType, "video/H265")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildVideoLink() {
        let object = try? ActivityContent.Builders.Attachments.VideoLink()
            .setHref(URL(string: "https://www.example.com")!)
            .setMediaType("video/H265")
            .setSize(CGSize(width: 320, height: 480))
            .addHashes([
                try! ActivityContent.Builders.Hash()
                    .setAlgorithm("keccak")
                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.hash?.first?.algorithm, "keccak")
        XCTAssertEqual(object?.mediaType, "video/H265")
        XCTAssertEqual(object?.width, 320)
        XCTAssertEqual(object?.height, 480)
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildLinkAttachment() {
        let object = try? ActivityContent.Builders.Attachments.Link()
            .setName("Link Attachment")
            .setHref(URL(string: "https://www.example.com")!)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Link")
        XCTAssertEqual(object?.name, "Link Attachment")
        XCTAssertEqual(object?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildLocation() {
        let object = try? ActivityContent.Builders.Location()
            .setName("Location Name")
            .setAccuracy(100)
            .setAltitude(200)
            .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.45))
            .setRadius(50)
            .setUnits(.km)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Place")
        XCTAssertEqual(object?.name, "Location Name")
        XCTAssertEqual(object?.accuracy, 100)
        XCTAssertEqual(object?.altitude, 200)
        XCTAssertEqual(object?.latitude, 123.45)
        XCTAssertEqual(object?.longitude, -123.45)
        XCTAssertEqual(object?.radius, 50)
        XCTAssertEqual(object?.units, .km)
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildHashtag() {
        let object = try? ActivityContent.Builders.Tags.Hashtag()
            .setName("#hashtag")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.name, "#hashtag")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildMention() {
        let object = try? ActivityContent.Builders.Tags.Mention()
            .setName("Mention Name")
            .setDSNPUserId("dsnp://1234")
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.type, "Mention")
        XCTAssertEqual(object?.name, "Mention Name")
        XCTAssertEqual(object?.id, "dsnp://1234")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildNote() {
        let object = try? ActivityContent.Builders.Note()
            .setContent("Note Content")
            .setName("Note Name")
            .setPublished(Date(timeIntervalSince1970: 1640321788.6924329))
            .addAttachments([
                try! ActivityContent.Builders.Attachments.Audio()
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
                    .build(),
                try! ActivityContent.Builders.Attachments.Image()
                    .addImageLinks([
                        try! ActivityContent.Builders.Attachments.ImageLink()
                            .setHref(URL(string: "https://www.example.com")!)
                            .setMediaType("image/png")
                            .addHashes([
                                try! ActivityContent.Builders.Hash()
                                    .setAlgorithm("keccak")
                                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                    .build()
                            ])
                            .build()
                    ])
                    .build(),
                try! ActivityContent.Builders.Attachments.Video()
                    .addVideoLinks([
                        try! ActivityContent.Builders.Attachments.VideoLink()
                            .setHref(URL(string: "https://www.example.com")!)
                            .setMediaType("video/H265")
                            .addHashes([
                                try! ActivityContent.Builders.Hash()
                                    .setAlgorithm("keccak")
                                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                    .build()
                            ])
                            .build()
                    ])
                    .build(),
                try! ActivityContent.Builders.Attachments.Link()
                    .setName("Link Attachment")
                    .setHref(URL(string: "https://www.example.com")!)
                    .build()
            ])
            .addTags([
                try! ActivityContent.Builders.Tags.Hashtag()
                    .setName("#hashtag")
                    .build(),
                try! ActivityContent.Builders.Tags.Mention()
                    .setDSNPUserId("dsnp://1234")
                    .build()
            ])
            .setLocation(try! ActivityContent.Builders.Location()
                            .setName("Location Name")
                            .build())
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.type, "Note")
        XCTAssertEqual(object?.mediaType, "text/plain")
        XCTAssertEqual(object?.name, "Note Name")
        XCTAssertEqual(object?.content, "Note Content")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertEqual(object?.location?.name, "Location Name")
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.attachment?.count, 4)
        XCTAssertEqual((object?.attachment?[0] as? ActivityContentAudioAttachment)?.url?.first?.mediaType, "audio/ogg")
        XCTAssertEqual((object?.attachment?[1] as? ActivityContentImageAttachment)?.url?.first?.mediaType, "image/png")
        XCTAssertEqual((object?.attachment?[2] as? ActivityContentVideoAttachment)?.url?.first?.mediaType, "video/H265")
        XCTAssertEqual((object?.attachment?[3] as? ActivityContentLinkAttachment)?.href?.absoluteString, "https://www.example.com")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildProfile() {
        let object = try? ActivityContent.Builders.Profile()
            .setName("Profile Name")
            .addIcons([
                try! ActivityContent.Builders.Attachments.ImageLink()
                    .setHref(URL(string: "https://www.example.com")!)
                    .setMediaType("image/png")
                    .addHashes([
                        try! ActivityContent.Builders.Hash()
                            .setAlgorithm("keccak")
                            .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                            .build()
                    ])
                    .build()
            ])
            .setSummary("Profile Summary")
            .setPublished(Date(timeIntervalSince1970: 1640321788.6924329))
            .setLocation(try! ActivityContent.Builders.Location()
                            .setName("Location Name")
                            .build())
            .addTags([
                try! ActivityContent.Builders.Tags.Hashtag()
                    .setName("#hashtag")
                    .build(),
                try! ActivityContent.Builders.Tags.Mention()
                    .setDSNPUserId("dsnp://1234")
                    .build()
            ])
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.context, "https://www.w3.org/ns/activitystreams")
        XCTAssertEqual(object?.type, "Profile")
        XCTAssertEqual(object?.name, "Profile Name")
        XCTAssertEqual(object?.icon?.count, 1)
        XCTAssertEqual(object?.icon?[0].mediaType, "image/png")
        XCTAssertEqual(object?.summary, "Profile Summary")
        XCTAssertEqual(object?.published?.timeIntervalSince1970, 1640321788.6924329)
        XCTAssertEqual(object?.location?.name, "Location Name")
        XCTAssertEqual(object?.tag?.count, 2)
        XCTAssertEqual((object?.tag?[0] as? ActivityContentHashtag)?.name, "#hashtag")
        XCTAssertEqual((object?.tag?[1] as? ActivityContentMention)?.id, "dsnp://1234")
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
}
