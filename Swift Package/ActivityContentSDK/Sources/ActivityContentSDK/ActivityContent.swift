//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation

public class ActivityContent {
    
    public static func createNote(content: String,
                                  mediaType: String) -> Note? {
        return Note(content: content, mediaType: mediaType)
    }
    
}
