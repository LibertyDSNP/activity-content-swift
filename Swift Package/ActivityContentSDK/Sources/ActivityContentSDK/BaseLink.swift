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
    
    private enum CodingKeys: String, CodingKey {
        case type
        case href
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var additionalFields: [String : Any] = [:]
        for key in container.allKeys {
            guard let dynamicCodingKey = DynamicCodingKeys(stringValue: key.stringValue) else { continue }
            switch CodingKeys(stringValue: key.stringValue) {
            case .href:
                self.href = try container.decode(URL.self, forKey: dynamicCodingKey)
            case .type:
                self.type = try container.decode(String.self, forKey: dynamicCodingKey)
            case .none:
                let anyCodable = try container.decode(AnyCodable.self, forKey: dynamicCodingKey)
                additionalFields[key.stringValue] = anyCodable.value
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
