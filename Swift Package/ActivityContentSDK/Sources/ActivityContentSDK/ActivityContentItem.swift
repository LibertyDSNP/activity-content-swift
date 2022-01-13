//
//  ActivityContentItem.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/12/22.
//

import Foundation
import AnyCodable

public class ActivityContentItem: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    
    internal var additionalFields: [String : AnyCodable]?
    
    internal var storedJson: String?

    internal init() {}
}
