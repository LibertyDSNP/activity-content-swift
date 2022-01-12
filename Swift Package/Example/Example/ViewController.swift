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
        
        self.buildNote()
        //        self.buildProfile()
        //        self.buildAttachments()
    }
    
    private func buildNote() {
        do {
            
            let hashUnsupported = try ActivityContent.HashBuilder()
                .setAlgorithm("keccak256")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let hashSupported = try ActivityContent.HashBuilder()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkUnsupported = try ActivityContent.ImageLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/fake")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageLinkSupported = try ActivityContent.ImageLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageAttachment = try ActivityContent.ImageAttachmentBuilder()
                .setName("Image Attachment")
                .addImageLinks([imageLinkUnsupported, imageLinkSupported])
                .build()
            
            let hashtag = try ActivityContent.HashtagBuilder()
                .setName("#hashtag")
                .build()
            
            let mention = try ActivityContent.MentionBuilder()
                .setName("Mention Name")
                .setDSNPUserId("dsnp://1234")
                .build()
            
            let location = try ActivityContent.LocationBuilder()
                .setName("Location Name")
                .setAccuracy(50)
                .setAltitude(100)
                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                .setRadius(25)
                .setUnits(.cm)
                .build()
            
            let note = try ActivityContent.NoteBuilder()
                .setContent("Note Content")
                .setName("Note Name")
                .setPublished(Date.now)
                .addAttachments([imageAttachment])
                .addTags([hashtag, mention])
                .setLocation(location)
                .build()
            
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildProfile() {
        do {
            
            let hashUnsupported = try ActivityContent.HashBuilder()
                .setAlgorithm("keccak256")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let hashSupported = try ActivityContent.HashBuilder()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkUnsupported = try ActivityContent.ImageLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/fake")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let imageLinkSupported = try ActivityContent.ImageLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashUnsupported, hashSupported])
                .build()
            
            let location = try ActivityContent.LocationBuilder()
                .setName("Location Name")
                .setAccuracy(50)
                .setAltitude(100)
                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                .setRadius(25)
                .setUnits(.cm)
                .build()
            
            let hashtag = try ActivityContent.HashtagBuilder()
                .setName("#hashtag")
                .build()
            
            let mention = try ActivityContent.MentionBuilder()
                .setName("Mention Name")
                .setDSNPUserId("dsnp://1234")
                .build()
            
            let profile = try ActivityContent.ProfileBuilder()
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
            
            let hashSupported = try ActivityContent.HashBuilder()
                .setAlgorithm("keccak")
                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                .build()
            
            let imageLinkSupported = try ActivityContent.ImageLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("image/png")
                .addHashes([hashSupported])
                .build()
            
            let imageAttachment = try ActivityContent.ImageAttachmentBuilder()
                .setName("Image Attachment")
                .addImageLinks([imageLinkSupported])
                .build()
            
            let videoLinkSupported = try ActivityContent.VideoLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("video/mp4")
                .addHashes([hashSupported])
                .build()
            
            let videoAttachment = try ActivityContent.VideoAttachmentBuilder()
                .setName("Video Attachment")
                .addDuration(180)
                .addVideoLinks([videoLinkSupported])
                .build()
            
            let audioLinkSupported = try ActivityContent.AudioLinkBuilder()
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .setMediaType("audio/mpeg")
                .addHashes([hashSupported])
                .build()
            
            let audioAttachment = try ActivityContent.AudioAttachmentBuilder()
                .setName("Audio Attachment")
                .addDuration(240)
                .addAudioLinks([audioLinkSupported])
                .build()
            
            let linkAttachment = try ActivityContent.LinkAttachmentBuilder()
                .setName("Link Attachment")
                .setHref(URL(string: "http://www.example.com/image.png")!)
                .build()
            
            let attachments = [
                imageAttachment,
                videoAttachment,
                audioAttachment,
                linkAttachment
            ]
            
            let note = try ActivityContent.NoteBuilder()
                .setContent("Note Content")
                .addAttachments(attachments)
                .build()
            
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
}
