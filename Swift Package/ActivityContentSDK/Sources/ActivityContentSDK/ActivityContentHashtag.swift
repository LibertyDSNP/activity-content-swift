//
//  ActivityContentHashtag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentHashtag: ActivityContentBaseTag {
    
    /**
     The text of the tag
     */
    public internal(set) var name: String?
    
    internal override init() {
        super.init()
    }
    
    internal init(name: String) {
        self.name = name
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.name == nil {
            throw ActivityContentError.missingNameField
        }
        
        return true
    }
}
