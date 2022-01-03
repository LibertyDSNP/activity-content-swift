//
//  Attachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class AudioAttachment: Codable {
    public private(set) var type: String = "Audio"
    public var url: [AudioLink]
    public var name: String?
    public var duration: TimeInterval?
    
    init(url: [AudioLink],
         name: String?,
         duration: TimeInterval?) {
        self.url = url
        self.name = name
        self.duration = duration
    }
}

class AudioLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
    
    init(href: URL,
         mediaType: String,
         hash: [Hash]) {
        self.href = href
        self.mediaType = mediaType
        self.hash = hash
    }
}

// ---

class ImageAttachment: Codable {
    public private(set) var type: String = "Image"
    public var url: [ImageLink]
    public var name: String?
    
    init(url: [ImageLink],
         name: String?) {
        self.url = url
        self.name = name
    }
}

class ImageLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
    
    init(href: URL,
         mediaType: String,
         hash: [Hash],
         height: Float?,
         width: Float?) {
        self.href = href
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
    }
}

// ---

class VideoAttachment: Codable {
    public private(set) var type: String = "Video"
    public var url: [VideoLink]
    public var name: String?
    public var duration: TimeInterval?
    
    init(url: [VideoLink],
         name: String?,
         duration: TimeInterval?) {
        self.url = url
        self.name = name
        self.duration = duration
    }
}

class VideoLink: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
    
    init(href: URL,
         mediaType: String,
         hash: [Hash],
         height: Float?,
         width: Float?) {
        self.href = href
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
    }
}

// ---

class Link: Codable {
    public private(set) var type: String = "Link"
    public var href: URL
    public var name: String?
    
    init(href: URL,
         name: String?) {
        self.href = href
        self.name = name
    }
}
