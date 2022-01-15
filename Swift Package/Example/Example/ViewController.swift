//
//  ViewController.swift
//  Example
//
//  Created by Unfinished on 1/5/22.
//

import UIKit
import ActivityContentSDK
import CoreLocation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.buildNote()
//         self.buildProfile()
         self.buildAttachments()
    }
    
    private func buildNote() {
        do {
            
            let hashUnsupported = try ActivityContent.Builders.Hash()
                .setAlgorithm("keccak256")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let hashSupported = try ActivityContent.Builders.Hash()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkUnsupported = try ActivityContent.Builders.Attachments.ImageLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/fake")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageLinkSupported = try ActivityContent.Builders.Attachments.ImageLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageAttachment = try ActivityContent.Builders.Attachments.Image()
                .setName("Image Attachment")
                .addImageLinks([imageLinkUnsupported, imageLinkSupported])
                .build()
            
            let hashtag = try ActivityContent.Builders.Tags.Hashtag()
                .setName("#hashtag")
                .build()
            
            let mention = try ActivityContent.Builders.Tags.Mention()
                .setName("Mention Name")
                .setDSNPUserId("dsnp://1234")
                .build()
            
            let location = try ActivityContent.Builders.Location()
                .setName("Location Name")
                .setAccuracy(50)
                .setAltitude(100)
                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                .setRadius(25)
                .setUnits(.cm)
                .build()
            
            let additionalFields: [String : Any] = [
                "content" : "override", // ignored
                "customBool" : true,
                "customString" : "hello",
                "customLink" : try ActivityContent.Builders.Attachments.Link()
                    .setHref(URL(string: "http://www.example.com")!)
                    .build()
            ]
            
            let note = try ActivityContent.Builders.Note()
                .setContent("Note Content")
                .setName("Note Name")
                .setPublished(Date.now)
                .addAttachments([imageAttachment])
                .addTags([hashtag, mention])
                .setLocation(location)
                .addAdditionalFields(additionalFields)
                .build()
            
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildProfile() {
        do {
            
            let hashUnsupported = try ActivityContent.Builders.Hash()
                .setAlgorithm("keccak256")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let hashSupported = try ActivityContent.Builders.Hash()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkUnsupported = try ActivityContent.Builders.Attachments.ImageLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/fake")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageLinkSupported = try ActivityContent.Builders.Attachments.ImageLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let location = try ActivityContent.Builders.Location()
                .setName("Location Name")
                .setAccuracy(50)
                .setAltitude(100)
                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                .setRadius(25)
                .setUnits(.cm)
                .build()
            
            let hashtag = try ActivityContent.Builders.Tags.Hashtag()
                .setName("#hashtag")
                .build()
            
            let mention = try ActivityContent.Builders.Tags.Mention()
                .setName("Mention Name")
                .setDSNPUserId("dsnp://1234")
                .build()
            
            let profile = try ActivityContent.Builders.Profile()
                .setName("Profile Name")
                .addIcons([imageLinkUnsupported, imageLinkSupported])
                .setSummary("Profile Summary")
                .setPublished(Date.now)
                .setLocation(location)
                .addTags([hashtag, mention])
                .build()
            
            print(profile.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildAttachments() {
        do {
            
            let hashSupported = try ActivityContent.Builders.Hash()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkSupported = try ActivityContent.Builders.Attachments.ImageLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashSupported])
                .build()
            
            let imageAttachment = try ActivityContent.Builders.Attachments.Image()
                .setName("Image Attachment")
                .addImageLinks([imageLinkSupported])
                .build()
            
            let videoLinkSupported = try ActivityContent.Builders.Attachments.VideoLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("video/mp4")
                .addHashes([hashSupported])
                .build()
            
            let videoAttachment = try ActivityContent.Builders.Attachments.Video()
                .setName("Video Attachment")
                .addDuration(180)
                .addVideoLinks([videoLinkSupported])
                .build()
            
            let audioLinkSupported = try ActivityContent.Builders.Attachments.AudioLink()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("audio/mpeg")
                .addHashes([hashSupported])
                .build()
            
            let audioAttachment = try ActivityContent.Builders.Attachments.Audio()
                .setName("Audio Attachment")
                .addDuration(240)
                .addAudioLinks([audioLinkSupported])
                .build()
            
            let linkAttachment = try ActivityContent.Builders.Attachments.Link()
                .setName("Link Attachment")
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .build()
            
            let attachments = [
                imageAttachment,
                videoAttachment,
                audioAttachment,
                linkAttachment
            ]
            
            let note = try ActivityContent.Builders.Note()
                .setContent("Note Content")
                .addAttachments(attachments)
                .build()
            
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
}
