//
//  Attachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation
import AnyCodable

public class ActivityContentItem: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    var additionalFields: [String : AnyCodable]?
    
    internal var storedJson: String?
    
    internal init() {}
}

public class BaseAttachment: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    var additionalFields: [String : AnyCodable]?
    
    internal var storedJson: String?
    
    internal init() {}
}
