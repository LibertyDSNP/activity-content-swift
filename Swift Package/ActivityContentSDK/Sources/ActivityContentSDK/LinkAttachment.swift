//
//  LinkAttachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

public class LinkAttachment: BaseLink {
    
    /**
     The display name for the link
     */
    internal var name: String?
    
    internal override init() {
        super.init()
    }
    
    internal init(href: URL,
                  name: String? = nil) throws {
        self.name = name
        try super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
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
        try container.encode(self.name, forKey: .name)
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if ValidationUtil.isValid(href: self.href) == false {
            throw ActivityContentError.invalidHref
        }
        
        return true
    }
}
