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
            attachment: nil,
            tag: nil,
            location: location)
    }
}
