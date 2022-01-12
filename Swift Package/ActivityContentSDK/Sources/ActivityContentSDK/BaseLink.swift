//
//  BaseLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation
import AnyCodable

public class BaseLink: BaseAttachment {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Link
     */
    public private(set) var type: String = "Link"
    
    /**
     The URL for the given link
     
     - Requires: MUST be a Supported URL Schema
     */
    public internal(set) var href: URL?
    
    internal override init() {
        super.init()
    }
    
    internal init(href: URL) {
        self.href = href
        super.init()
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            /// We are not using this, return nil
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case href
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//        self.type = try container.decode(String.self, forKey: .type)
//        self.href = try container.decode(URL.self, forKey: .href)
        
        var additionalFields: [String : AnyCodable] = [:]
        
        for key in container.allKeys {
            if let codingKey = CodingKeys(stringValue: key.stringValue) {
                if codingKey == .href {
                    self.href = try container.decode(URL.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                } else if codingKey == .type {
                    self.type = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                }
            } else {
                additionalFields[key.stringValue] = try container.decode(AnyCodable.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            }
        }

        try super.init(from: decoder)
        self.additionalFields = additionalFields.isEmpty == false ? additionalFields : nil
        print(additionalFields)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.href, forKey: .href)
    }
}
