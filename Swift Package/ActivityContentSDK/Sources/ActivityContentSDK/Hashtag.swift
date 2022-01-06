//
//  Hashtag.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

public class Hashtag: BaseTag {
    
    /**
     The text of the tag
     */
    public var name: String
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey { case name }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.name = try container.decode(String.self, forKey: .name)
        try super.init(from: superdecoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}
