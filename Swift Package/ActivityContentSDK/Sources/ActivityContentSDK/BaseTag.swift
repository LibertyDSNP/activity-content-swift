//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation
import AnyCodable

public class BaseTag: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    var additionalFields: [String : AnyCodable]?
    
    internal var storedJson: String?
    
    internal init() {}
}
