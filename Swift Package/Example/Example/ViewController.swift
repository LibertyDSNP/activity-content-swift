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
        
        let note = ActivityContent.createNote(content: "This is content", mediaType: "text/plain")
        print(note!)
    }


}

