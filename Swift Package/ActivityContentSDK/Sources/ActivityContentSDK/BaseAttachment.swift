//
//  Attachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class BaseAttachment: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    
    internal var storedJson: String?
    
    internal init() {}
}
