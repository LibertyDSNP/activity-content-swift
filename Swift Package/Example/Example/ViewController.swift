//
//  ViewController.swift
//  Example
//
//  Created by Rigo Carbajal on 1/5/22.
//

import UIKit
import ActivityContentSDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hash = ActivityContent.createHash(algorithm: "keccak256", value: "0x1234")
        let imageLink = ActivityContent.createImageLink(href: URL(string: "http://www.example.com/image.png")!, mediaType: "image/png", hash: [hash], height: 200, width: 300)
        let imageAttachment = ActivityContent.createImageAttachment(url: [imageLink], name: "Image Attachment")
        let attachments = [imageAttachment]
        
        let hashtag = ActivityContent.createHashtag(name: "#hashtag")
        let tags = [hashtag]
        
        let location = ActivityContent.createLocation(
            name: "Location",
            accuracy: 50,
            altitude: 100,
            latitude: 123.45,
            longitude: -123.45,
            radius: 25,
            units: .feet)
        
        _ = ActivityContent.createNote(
            content: "This is a note",
            mediaType: "text/plain",
            name: "Sample Name",
            published: Date(timeIntervalSince1970: 1640321788.6924329),
            attachment: attachments,
            tag: tags,
            location: location)
        
    }
}
