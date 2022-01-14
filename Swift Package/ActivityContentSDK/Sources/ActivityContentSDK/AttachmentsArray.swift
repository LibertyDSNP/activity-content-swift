//
//  AttachmentsArray.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/4/22.
//

import Foundation

class AttachmentsArray: Codable {
    
    internal let attachments: [ActivityContentBaseAttachment]?
    
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
        var attachments: [ActivityContentBaseAttachment] = []
        var attachmentsArray = container
        while (!container.isAtEnd) {
            let tag = try container.nestedContainer(keyedBy: AttachmentsTypeKey.self)
            let type = try tag.decodeIfPresent(AttachmentTypes.self, forKey: AttachmentsTypeKey.type)
            switch type {
            case .audio:
                attachments.append(try attachmentsArray.decode(ActivityContentAudioAttachment.self))
            case .image:
                attachments.append(try attachmentsArray.decode(ActivityContentImageAttachment.self))
            case .video:
                attachments.append(try attachmentsArray.decode(ActivityContentVideoAttachment.self))
            case .link:
                attachments.append(try attachmentsArray.decode(ActivityContentLinkAttachment.self))
            case .none:
                break
            }
        }
        
        self.attachments = attachments.isEmpty ? nil : attachments
    }
}
