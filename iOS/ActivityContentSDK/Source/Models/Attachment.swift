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

// ---

class BaseLink: Attachment {
    public private(set) var type: String = "Link"
    public var href: URL
    
    init(href: URL) {
        self.href = href
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case href
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let superdecoder = try container.superDecoder()
        self.type = try container.decode(String.self, forKey: .type)
        self.href = try container.decode(URL.self, forKey: .href)
        try super.init(from: superdecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.href, forKey: .href)
    }
}

class Link: BaseLink {
    public var name: String?
    
    init(href: URL,
         name: String?) {
        self.name = name
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decode(String.self, forKey: .name)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

class AudioLink: BaseLink {
    public var mediaType: String
    public var hash: [Hash]
    
    init(href: URL,
         mediaType: String,
         hash: [Hash]) {
        self.mediaType = mediaType
        self.hash = hash
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case mediaType
        case hash
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([Hash].self, forKey: .hash)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
    }
}

class ImageLink: BaseLink {
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
    
    init(href: URL,
         mediaType: String,
         hash: [Hash],
         height: Float?,
         width: Float?) {
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case mediaType
        case hash
        case height
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([Hash].self, forKey: .hash)
        self.height = try container.decode(Float.self, forKey: .height)
        self.width = try container.decode(Float.self, forKey: .width)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.width, forKey: .width)
    }
}

class VideoLink: BaseLink {
    public var mediaType: String
    public var hash: [Hash]
    public var height: Float?
    public var width: Float?
    
    init(href: URL,
         mediaType: String,
         hash: [Hash],
         height: Float?,
         width: Float?) {
        self.mediaType = mediaType
        self.hash = hash
        self.height = height
        self.width = width
        super.init(href: href)
    }
    
    private enum CodingKeys: String, CodingKey {
        case mediaType
        case hash
        case height
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.hash = try container.decode([Hash].self, forKey: .hash)
        self.height = try container.decode(Float.self, forKey: .height)
        self.width = try container.decode(Float.self, forKey: .width)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mediaType, forKey: .mediaType)
        try container.encode(self.hash, forKey: .hash)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.width, forKey: .width)
    }
}
