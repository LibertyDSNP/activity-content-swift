//
//  ActivityContentItem.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/12/22.
//

import Foundation
import AnyCodable

public class ActivityContentItem: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    
    internal var additionalFields: [String : Any]?
    
    internal var jsonSource: String?

    internal init() {}
    
    private  enum CodingKeys: CodingKey {}
}
