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
                .withContent("Note Content")
                .withName("Note Name")
                .withPublished(Date.now)
                .addAttachments([
                    try ActivityContent.Builders.Attachments.Image()
                        .withName("Image Attachment")
                        .addImageLinks([
                            try ActivityContent.Builders.Attachments.ImageLink()
                                .withHref(URL(string: "http://www.example.com/image.png")!)
                                .withMediaType(.png)
                                .addHashes([
                                    try ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum").build()
                                ])
                                .build()
                        ])
                        .build()
                ])
                .addTags([
                    try ActivityContent.Builders.Tags.Hashtag()
                        .withName("#hashtag")
                        .build(),
                    try ActivityContent.Builders.Tags.Mention()
                        .withName("Mention Name")
                        .withDSNPUserId("dsnp://1234")
                        .build()
                ])
                .withLocation(try ActivityContent.Builders.Location()
                                .withName("Location Name")
                                .withAccuracy(50)
                                .withAltitude(100)
                                .withCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                                .withRadius(25)
                                .withUnits(.cm)
                                .build())
                .addAdditionalFields([
                    "content" : "override", // ignored
                    "customBool" : true,
                    "customString" : "hello",
                    "customLink" : try ActivityContent.Builders.Attachments.Link()
                        .withHref(URL(string: "http://www.example.com")!)
                        .build()
                ])
                .build()
            
            print("\nNOTE\n____")
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
    
    private func buildProfile() {
        do {
            
            let profile = try ActivityContent.Builders.Profile()
                .withName("Profile Name")
                .addIcons([
                    try ActivityContent.Builders.Attachments.ImageLink()
                        .withHref(URL(string: "http://www.example.com/image.png")!)
                        .withMediaType(.png)
                        .addHashes([
                            try ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum").build()
                        ])
                        .build()
                ])
                .withSummary("Profile Summary")
                .withPublished(Date.now)
                .withLocation(try ActivityContent.Builders.Location()
                                .withName("Location Name")
                                .withAccuracy(50)
                                .withAltitude(100)
                                .withCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.34))
                                .withRadius(25)
                                .withUnits(.cm)
                                .build())
                .addTags([
                    try ActivityContent.Builders.Tags.Hashtag()
                        .withName("#hashtag")
                        .build(),
                    try ActivityContent.Builders.Tags.Mention()
                        .withName("Mention Name")
                        .withDSNPUserId("dsnp://1234")
                        .build()
                ])
                .build()
            
            print("\nPROFILE\n_______")
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
                    .withName("Image Attachment")
                    .addImageLinks([
                        try ActivityContent.Builders.Attachments.ImageLink()
                            .withHref(URL(string: "http://www.example.com/image.png")!)
                            .withMediaType(.png)
                            .addHashes([
                                try ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum").build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Video Attachment
                try ActivityContent.Builders.Attachments.Video()
                    .withName("Video Attachment")
                    .addDuration(180)
                    .addVideoLinks([
                        try ActivityContent.Builders.Attachments.VideoLink()
                            .withHref(URL(string: "http://www.example.com/image.png")!)
                            .withMediaType("video/mp4")
                            .addHashes([
                                try ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum").build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Audio Attachment
                try ActivityContent.Builders.Attachments.Audio()
                    .withName("Audio Attachment")
                    .addDuration(240)
                    .addAudioLinks([
                        try ActivityContent.Builders.Attachments.AudioLink()
                            .withHref(URL(string: "http://www.example.com/image.png")!)
                            .withMediaType("audio/mpeg")
                            .addHashes([
                                try ActivityContent.Builders.Hash(keccakHashWithString: "Lorem Ipsum").build()
                            ])
                            .build()
                    ])
                    .build(),
                
                // Link Attachment
                try ActivityContent.Builders.Attachments.Link()
                    .withName("Link Attachment")
                    .withHref(URL(string: "http://www.example.com/image.png")!)
                    .build()
            ]
            
            let note = try ActivityContent.Builders.Note()
                .withContent("Note Content")
                .addAttachments(attachments)
                .build()
            
            print("\nATTACHMENTS\n__________")
            print(note.json!)
            
        } catch {
            print(error)
        }
    }
}
