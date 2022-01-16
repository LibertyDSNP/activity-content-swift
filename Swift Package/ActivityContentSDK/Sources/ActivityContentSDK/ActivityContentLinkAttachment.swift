//
//  ActivityContentLinkAttachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class ActivityContentLinkAttachment: ActivityContentBaseLink {
    
    /**
     The display name for the link
     */
    public internal(set) var name: String?
    
    internal required init() {
        super.init()
    }
    
    internal init(href: URL,
                  name: String? = nil) {
        self.name = name
        super.init(href: href)
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let name = self.name {
            try container.encode(name, forKey: .name)
        }
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.href == nil {
            throw ActivityContentError.missingHrefField
        }
        
        if ValidationUtil.isValid(href: self.href) == false {
            throw ActivityContentError.invalidHref
        }
        
        return true
    }
}
