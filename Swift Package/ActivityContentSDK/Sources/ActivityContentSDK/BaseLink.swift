//
//  BaseLink.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

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
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case href
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.href = try container.decode(URL.self, forKey: .href)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.href, forKey: .href)
    }
}
