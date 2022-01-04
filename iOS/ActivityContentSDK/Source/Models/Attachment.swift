//
//  Attachment.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class AttachmentsArray: Codable {

    let attachments: [Attachment]

    enum AttachmentsTypeKey: CodingKey {
        case type
    }

    enum AttachmentTypes: String, Decodable {
        case audio = "Audio"
        case image = "Image"
        case video = "Video"
        case link = "Link"
    }

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var attachments: [Attachment] = []
        var attachmentsArray = container
        while (!container.isAtEnd) {
            let tag = try container.nestedContainer(keyedBy: AttachmentsTypeKey.self)
            let type = try tag.decodeIfPresent(AttachmentTypes.self, forKey: AttachmentsTypeKey.type)
            switch type {
            case .audio:
                attachments.append(try attachmentsArray.decode(AudioAttachment.self))
            case .image:
                attachments.append(try attachmentsArray.decode(ImageAttachment.self))
            case .video:
                attachments.append(try attachmentsArray.decode(VideoAttachment.self))
            case .link:
                attachments.append(try attachmentsArray.decode(Link.self))
            case .none:
                break
            }
        }

        self.attachments = attachments
    }
}

class Attachment: Codable {
}

class AudioAttachment: Attachment {
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
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case url
        case name
        case duration
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([AudioLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        self.duration = try? container.decode(TimeInterval.self, forKey: .duration)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.duration, forKey: .duration)
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

class ImageAttachment: Attachment {
    public private(set) var type: String = "Image"
    public var url: [ImageLink]
    public var name: String?
    
    init(url: [ImageLink],
         name: String?) {
        self.url = url
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case url
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([ImageLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
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

class VideoAttachment: Attachment {
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
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case url
        case name
        case duration
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.url = try container.decode([VideoLink].self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
        self.duration = try? container.decode(TimeInterval.self, forKey: .duration)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.duration, forKey: .duration)
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

class Link: Attachment {
    public private(set) var type: String = "Link"
    public var href: URL
    public var name: String?
    
    init(href: URL,
         name: String?) {
        self.href = href
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case href
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.href = try container.decode(URL.self, forKey: .href)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.href, forKey: .href)
        try container.encode(self.name, forKey: .name)
    }
}
