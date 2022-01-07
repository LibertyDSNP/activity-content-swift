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
        
        do {
            
            // Create new Note
            let hash = try ActivityContent.createHash(algorithm: "keccak256", value: "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7")
            let imageLink = try ActivityContent.createImageLink(href: URL(string: "http://www.example.com/image.png")!, mediaType: "image/png", hash: [hash], height: 200, width: 300)
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
            
            let note = ActivityContent.createNote(
                content: "This is a note",
                mediaType: "text/plain",
                name: "Sample Name",
                published: Date(timeIntervalSince1970: 1640321788.6924329),
                attachment: attachments,
                tag: tags,
                location: location)
            
            // to JSON
            guard let json = note.json else {
                print("Error generating JSON")
                return
            }
            
            // from JSON
            _ = Note.from(json: json)

            print(json)
            
        } catch {
            print(error)
        }
        
    }
}
