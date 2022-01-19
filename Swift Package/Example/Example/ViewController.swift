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
        self.buildProfile()
        self.buildAttachments()
    }
    
    private func buildNote() {
        do {
            
            let note = try ActivityContent.Builders.Note()
                .setContent("Note Content")
                .setName("Note Name")
                .setPublished(Date.now)
                .addAttachments([
                    try ActivityContent.Builders.Attachments.Image()
                        .setName("Image Attachment")
                        .addImageLinks([
                            try ActivityContent.Builders.Attachments.ImageLink()
                                .setHref(URL(string: "http://www.example.com/image.png")!)
                                .setMediaType("image/png")
                                .addHashes([
                                    try ActivityContent.Builders.Hash()
                                        .setAlgorithm("keccak")
                                        .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                        .build()
                                ])
                                .build()
                        ])
                        .build()
                ])
                .addTags([
                    try ActivityContent.Builders.Tags.Hashtag()
                        .setName("#hashtag")
                        .build(),
                    try ActivityContent.Builders.Tags.Mention()
                        .setName("Mention Name")
                        .setDSNPUserId("dsnp://1234")
                        .build()
                ])
                .setLocation(try ActivityContent.Builders.Location()
                                .setName("Location Name")
                                .setAccuracy(50)
                                .setAltitude(100)
                                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                                .setRadius(25)
                                .setUnits(.cm)
                                .build())
                .addAdditionalFields([
                    "content" : "override", // ignored
                    "customBool" : true,
                    "customString" : "hello",
                    "customLink" : try ActivityContent.Builders.Attachments.Link()
                        .setHref(URL(string: "http://www.example.com")!)
                        .build()
                ])
                .build()
            
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildProfile() {
        do {
            
            let profile = try ActivityContent.Builders.Profile()
                .setName("Profile Name")
                .addIcons([
                    try ActivityContent.Builders.Attachments.ImageLink()
                        .setHref(URL(string: "http://www.example.com/image.png")!)
                        .setMediaType("image/png")
                        .addHashes([
                            try ActivityContent.Builders.Hash()
                                .setAlgorithm("keccak")
                                .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                .build()
                        ])
                        .build()
                ])
                .setSummary("Profile Summary")
                .setPublished(Date.now)
                .setLocation(try ActivityContent.Builders.Location()
                                .setName("Location Name")
                                .setAccuracy(50)
                                .setAltitude(100)
                                .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                                .setRadius(25)
                                .setUnits(.cm)
                                .build())
                .addTags([
                    try ActivityContent.Builders.Tags.Hashtag()
                        .setName("#hashtag")
                        .build(),
                    try ActivityContent.Builders.Tags.Mention()
                        .setName("Mention Name")
                        .setDSNPUserId("dsnp://1234")
                        .build()
                ])
                .build()
            
            print(profile.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildAttachments() {
        do {
            
            let attachments = [
                
                // Image Attachment
                try ActivityContent.Builders.Attachments.Image()
                    .setName("Image Attachment")
                    .addImageLinks([
                        try ActivityContent.Builders.Attachments.ImageLink()
                            .setHref(URL(string: "http://www.example.com/image.png")!)
                            .setMediaType("image/png")
                            .addHashes([
                                try ActivityContent.Builders.Hash()
                                    .setAlgorithm("keccak")
                                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                    .build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Video Attachment
                try ActivityContent.Builders.Attachments.Video()
                    .setName("Video Attachment")
                    .addDuration(180)
                    .addVideoLinks([
                        try ActivityContent.Builders.Attachments.VideoLink()
                            .setHref(URL(string: "http://www.example.com/image.png")!)
                            .setMediaType("video/mp4")
                            .addHashes([
                                try ActivityContent.Builders.Hash()
                                    .setAlgorithm("keccak")
                                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                    .build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Audio Attachment
                try ActivityContent.Builders.Attachments.Audio()
                    .setName("Audio Attachment")
                    .addDuration(240)
                    .addAudioLinks([
                        try ActivityContent.Builders.Attachments.AudioLink()
                            .setHref(URL(string: "http://www.example.com/image.png")!)
                            .setMediaType("audio/mpeg")
                            .addHashes([
                                try ActivityContent.Builders.Hash()
                                    .setAlgorithm("keccak")
                                    .setValue("0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
                                    .build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Link Attachment
                try ActivityContent.Builders.Attachments.Link()
                    .setName("Link Attachment")
                    .setHref(URL(string: "http://www.example.com/image.png")!)
                    .build()
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
