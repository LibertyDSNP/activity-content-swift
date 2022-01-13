//
//  ActivityContentItem.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/12/22.
//

import Foundation
import AnyCodable

public class ActivityContentItem: ActivityContentToJson, ActivityContentFromJson {
    
    public internal(set) var additionalFields: [String : Any]?
    
    internal var jsonSource: String?

    internal init() {}
    
    internal var allKeys: [CodingKey] { return CodingKeys.allCases }
    private enum CodingKeys: CodingKey, CaseIterable {}
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var additionalFields: [String : Any] = [:]

        let allKeysOnSelf = self.allKeys.map({ $0.stringValue })
        for key in container.allKeys {
            if allKeysOnSelf.contains(key.stringValue) == false {
                let anyCodable = try container.decode(AnyCodable.self, forKey: key)
                additionalFields[key.stringValue] = anyCodable.value
            }
        }
        
        self.additionalFields = additionalFields.isEmpty == false ? additionalFields : nil
    }

}
