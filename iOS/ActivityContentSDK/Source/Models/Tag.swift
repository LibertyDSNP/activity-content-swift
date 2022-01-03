//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Tag {}

class Hashtag: Tag, Codable {
    public var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Mention: Tag, Codable {
    public var name: String?
    public private(set) var type: String = "Mention"
    public var id: DSNPUserId
    
    init(name: String?,
         id: DSNPUserId) {
        self.name = name
        self.id = id
    }
}
