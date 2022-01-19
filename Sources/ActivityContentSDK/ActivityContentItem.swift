//
//  ActivityContentItem.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/12/22.
//

import Foundation
import AnyCodable

public class ActivityContentItem: ActivityContentToJson, ActivityContentFromJson {
    
    internal required init() {}
    
    public private(set) var additionalFields: [String : Any] = [:]
    internal func addAdditionalFields(_ additionalFields: [String : Any]) {
        self.additionalFields = self.additionalFields.merging(additionalFields, uniquingKeysWith: { (_, last) in last })
    }
    
    internal var allKeys: [CodingKey] { return CodingKeys.allCases }
    private enum CodingKeys: CodingKey, CaseIterable {}
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        let allKeysOnSelf = self.allKeys.map({ $0.stringValue })
        
        for (key, value) in self.additionalFields {
            if allKeysOnSelf.contains(key) == false {
                try container.encode(AnyCodable(value), forKey: DynamicCodingKeys(stringValue: key)!)
            } else {
                print("Warning: Preventing the attempted override of `\(key)`")
            }
        }
    }
    
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
        
        self.additionalFields = additionalFields
    }

    @discardableResult
    internal func isValid() throws -> Bool {
        return true
    }
}
