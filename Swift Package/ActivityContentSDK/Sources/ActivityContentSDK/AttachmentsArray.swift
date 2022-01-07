//
//  AttachmentsArray.swift
//  ActivityContentSDK
//
//  Created by Rigo Carbajal on 1/4/22.
//

import Foundation

class AttachmentsArray: ActivityContentItem {
    
    let attachments: [BaseAttachment]?
    
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
        var attachments: [BaseAttachment] = []
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
                attachments.append(try attachmentsArray.decode(LinkAttachment.self))
            case .none:
                break
            }
        }
        
        self.attachments = attachments.isEmpty ? nil : attachments
    }
}
