//
//  Note.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Note: Codable {
    
    /**
     JSON-LD @context
     
     - Requires: MUST be set to https://www.w3.org/ns/activitystreams
     */
    public private(set) var context: String = "https://www.w3.org/ns/activitystreams"
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Note
     */
    public private(set) var type: String = "Note"
    
    /**
     Text content of the note
     */
    public var content: String
    
    /**
     MIME type for the content field
     
     - Requires: MUST be set to a supported MIME type
     */
    public var mediaType: String
    
    /**
     The display name for the note
     */
    public var name: String?
    
    /**
     The time of publishing
     
     - Requires: MUST be ISO8601
     */
    public var published: Date?
    
    /**
     Array of attached links or media
     
     - Requires: MUST be one of the Supported Attachments
     */
    public var attachment: [ImageAttachment]?
    
    /**
     Array of tags/mentions
     
     - Requires: MUST follow Tag Type
     */
    public var tag: [Tag]?
    
    /**
     For location
     
     - Requires: MUST follow Location Type
     */
    public var location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, content, mediaType, name, published, attachment, tag, location
    }
    
    init(content: String,
         mediaType: String,
         name: String?,
         published: Date?,
         attachment: [ImageAttachment]?,
         tag: [Tag]?,
         location: Location?) {
        self.content = content
        self.mediaType = mediaType
        self.name = name
        self.published = published
        self.attachment = attachment
        self.tag = tag
        self.location = location
    }
    
    enum DrinkTypeKey: CodingKey {
            case type
        }
    
    enum DrinkTypes: String, Decodable {
           case mention = "Mention"
       }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.context = try container.decode(String.self, forKey: .context)
        self.type = try container.decode(String.self, forKey: .type)
        self.content = try container.decode(String.self, forKey: .content)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.name = try container.decode(String.self, forKey: .name)
        self.published = try container.decode(Date.self, forKey: .published)
        self.attachment = try container.decode([ImageAttachment].self, forKey: .attachment)
        
        let tagsArrayForType = try container.nestedUnkeyedContainer(forKey: .tag)
        self.tag = try Tags.parse(container: tagsArrayForType)
        
//        var tags = [Tag]()
//        var tagsArray = tagsArrayForType
//        while(!tagsArrayForType.isAtEnd) {
//            let tag = try tagsArrayForType.nestedContainer(keyedBy: DrinkTypeKey.self)
//            let type = try tag.decodeIfPresent(DrinkTypes.self, forKey: DrinkTypeKey.type)
//            switch type {
//            case .mention:
//                print("found mention")
//                tags.append(try tagsArray.decode(Mention.self))
//            case .none:
//                print("found hashtag")
//                tags.append(try tagsArray.decode(Hashtag.self))
//            }
//        }
//        self.tag = tags
        
        self.location = try container.decode(Location.self, forKey: .location)
    }
}
