//
//  ActivityContentMention.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentMention: ActivityContentBaseTag {
    
    /**
     The text of the tag
     */
    public internal(set) var name: String?
    
    /**
     Identifies the tag as type Mention
     
     - Requires: MUST be Mention
     */
    public private(set) var type: String = "Mention"
    
    /**
     Link to the user mentioned
     
     - Requires: MUST be a DSNP User URI
     */
    internal var id: DSNPUserId?
    
    internal required init() {
        super.init()
    }
    
    internal init(name: String? = nil,
                  id: DSNPUserId) {
        self.name = name
        self.id = id
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case name,
             type,
             id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.id = try? container.decode(DSNPUserId.self, forKey: .id)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.id, forKey: .id)
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.type != "Mention" {
            throw ActivityContentError.invalidType
        }
        
        if self.id == nil {
            throw ActivityContentError.missingDsnpUserUriField
        }
        
        if ValidationUtil.isValid(dsnpUserUri: self.id) == false {
            throw ActivityContentError.invalidDsnpUserUri
        }
        
        return try super.isValid()
    }
}
