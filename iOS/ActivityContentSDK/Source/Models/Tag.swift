//
//  Tag.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

protocol Tag {}

struct Hashtag: Tag, Codable {
    public var name: String
}

struct Mention: Tag, Codable {
    public var name: String?
    public private(set) var type: String = "Mention"
    public var id: DSNPUserId
}
