//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class BaseTag: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    
    internal var storedJson: String?
    
    internal init() {}
}
