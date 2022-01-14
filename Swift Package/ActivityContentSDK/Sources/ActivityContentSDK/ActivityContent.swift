//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation
import CoreGraphics
import CoreLocation

public struct ActivityContent {

    public struct Builders {
        
        public struct Tags {
         
//            public struct Mention {
//
//                private var mention = Mention()
//
//                public init() {}
//
//                @discardableResult
//                public func setName(_ name: String?) -> Self {
//                    self.mention.name = name
//                    return self
//                }
//
//                @discardableResult
//                public func setDSNPUserId(_ dsnpUserId: DSNPUserId) -> Self {
//                    self.mention.id = dsnpUserId
//                    return self
//                }
//
//                @discardableResult
//                public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
//                    self.mention.addAdditionalFields(additionalFields)
//                    return self
//                }
//
//                public func build() throws -> Mention {
//                    try self.mention.isValid()
//                    return self.mention
//                }
//            }
            
        }
        
    }
}

extension ActivityContent.Builders.Tags {
    
    public struct mention {
        
        private var mention = ActivityContentMention()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.mention.name = name
            return self
        }
        
        @discardableResult
        public func setDSNPUserId(_ dsnpUserId: DSNPUserId) -> Self {
            self.mention.id = dsnpUserId
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.mention.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentMention {
            try self.mention.isValid()
            return self.mention
        }
    }
}


 
extension ActivityContent {
    public struct NoteBuilder {

        private var note = Note()
        
        public init() {}
        
        @discardableResult
        public func setContent(_ content: String) -> Self {
            self.note.content = content
            return self
        }
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.note.name = name
            return self
        }
        
        @discardableResult
        public func setPublished(_ published: Date?) -> Self {
            self.note.published = published
            return self
        }
        
        @discardableResult
        public func addAttachments(_ attachments: [BaseAttachment]) -> Self {
            self.note.attachment?.append(contentsOf: attachments)
            return self
        }
        
        @discardableResult
        public func addTags(_ tags: [BaseTag]) -> Self {
            self.note.tag?.append(contentsOf: tags)
            return self
        }
        
        @discardableResult
        public func setLocation(_ location: Location?) -> Self {
            self.note.location = location
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.note.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> Note {
            try self.note.isValid()
            return self.note
        }
    }
    
    public struct ProfileBuilder {

        private var profile = Profile()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.profile.name = name
            return self
        }
        
        @discardableResult
        public func addIcons(_ icons: [ActivityContentImageLink]) -> Self {
            self.profile.icon?.append(contentsOf: icons)
            return self
        }
        
        @discardableResult
        public func setSummary(_ summary: String?) -> Self {
            self.profile.summary = summary
            return self
        }
        
        @discardableResult
        public func setPublished(_ published: Date?) -> Self {
            self.profile.published = published
            return self
        }
        
        @discardableResult
        public func setLocation(_ location: Location?) -> Self {
            self.profile.location = location
            return self
        }
        
        @discardableResult
        public func addTags(_ tags: [BaseTag]) -> Self {
            self.profile.tag?.append(contentsOf: tags)
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.profile.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> Profile {
            try self.profile.isValid()
            return self.profile
        }
    }
    
    public struct LinkAttachmentBuilder {
        
        private var linkAttachment = LinkAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.linkAttachment.name = name
            return self
        }
        
        @discardableResult
        public func setHref(_ href: URL) -> Self {
            self.linkAttachment.href = href
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.linkAttachment.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> LinkAttachment {
            try self.linkAttachment.isValid()
            return self.linkAttachment
        }
    }
    
    public struct AudioAttachmentBuilder {
        
        private var audioAttachment = ActivityContentAudioAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.audioAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addAudioLinks(_ audioLinks: [ActivityContentAudioLink]) -> Self {
            self.audioAttachment.url?.append(contentsOf: audioLinks)
            return self
        }
        
        @discardableResult
        public func addDuration(_ duration: TimeInterval?) -> Self {
            self.audioAttachment.duration = duration
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.audioAttachment.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentAudioAttachment {
            try self.audioAttachment.isValid()
            return self.audioAttachment
        }
    }
    
    public struct VideoAttachmentBuilder {
        
        private var videoAttachment = ActivityContentVideoAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.videoAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addVideoLinks(_ videoLinks: [ActivityContentVideoLink]) -> Self {
            self.videoAttachment.url?.append(contentsOf: videoLinks)
            return self
        }
        
        @discardableResult
        public func addDuration(_ duration: TimeInterval?) -> Self {
            self.videoAttachment.duration = duration
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.videoAttachment.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentVideoAttachment {
            try self.videoAttachment.isValid()
            return self.videoAttachment
        }
    }
    
    public struct AudioLinkBuilder {
        
        private var audioLink = ActivityContentAudioLink()
        
        public init() {}
        
        @discardableResult
        public func setHref(_ href: URL) -> Self {
            self.audioLink.href = href
            return self
        }
        
        @discardableResult
        public func setMediaType(_ mediaType: String) -> Self {
            self.audioLink.mediaType = mediaType
            return self
        }

        @discardableResult
        public func addHashes(_ hashes: [Hash]) -> Self {
            self.audioLink.hash?.append(contentsOf: hashes)
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.audioLink.addAdditionalFields(additionalFields)
            return self
        }

        public func build() throws -> ActivityContentAudioLink {
            try self.audioLink.isValid()
            return self.audioLink
        }
    }
    
    public struct VideoLinkBuilder {
     
        private var videoLink = ActivityContentVideoLink()
        
        public init() {}
        
        @discardableResult
        public func setHref(_ href: URL) -> Self {
            self.videoLink.href = href
            return self
        }
        
        @discardableResult
        public func setMediaType(_ mediaType: String) -> Self {
            self.videoLink.mediaType = mediaType
            return self
        }

        @discardableResult
        public func addHashes(_ hashes: [Hash]) -> Self {
            self.videoLink.hash?.append(contentsOf: hashes)
            return self
        }
        
        @discardableResult
        public func setSize(_ size: CGSize?) -> Self {
            self.videoLink.width = size?.width != nil ? Float(size!.width) : nil
            self.videoLink.height = size?.height != nil ? Float(size!.height) : nil
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.videoLink.addAdditionalFields(additionalFields)
            return self
        }

        public func build() throws -> ActivityContentVideoLink {
            try self.videoLink.isValid()
            return self.videoLink
        }
    }
    
    public struct HashtagBuilder {
        
        private var hashtag = Hashtag()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String) -> Self {
            self.hashtag.name = name
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.hashtag.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> Hashtag {
            try self.hashtag.isValid()
            return self.hashtag
        }
    }
    
    public struct MentionBuilder {
        
        private var mention = ActivityContentMention()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.mention.name = name
            return self
        }
        
        @discardableResult
        public func setDSNPUserId(_ dsnpUserId: DSNPUserId) -> Self {
            self.mention.id = dsnpUserId
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.mention.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentMention {
            try self.mention.isValid()
            return self.mention
        }
    }
    
    public struct HashBuilder {
        
        private var hash = Hash()
        
        public init() {}
        
        @discardableResult
        public func setAlgorithm(_ algorithm: String) -> Self {
            self.hash.algorithm = algorithm
            return self
        }
        
        @discardableResult
        public func setValue(_ value: String) -> Self {
            self.hash.value = value
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.hash.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> Hash {
            try self.hash.isValid()
            return self.hash
        }
    }
    
    public struct ImageLinkBuilder {
        
        private var imageLink = ActivityContentImageLink()
        
        public init() {}
        
        @discardableResult
        public func setHref(_ href: URL) -> Self {
            self.imageLink.href = href
            return self
        }
        
        @discardableResult
        public func setMediaType(_ mediaType: String) -> Self {
            self.imageLink.mediaType = mediaType
            return self
        }

        @discardableResult
        public func addHashes(_ hashes: [Hash]) -> Self {
            self.imageLink.hash?.append(contentsOf: hashes)
            return self
        }
        
        @discardableResult
        public func setSize(_ size: CGSize?) -> Self {
            self.imageLink.width = size?.width != nil ? Float(size!.width) : nil
            self.imageLink.height = size?.height != nil ? Float(size!.height) : nil
            return self
        }

        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.imageLink.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentImageLink {
            try self.imageLink.isValid()
            return self.imageLink
        }
    }
    
    public struct ImageAttachmentBuilder {
        
        private var imageAttachment = ActivityContentImageAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.imageAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addImageLinks(_ imageLinks: [ActivityContentImageLink]) -> Self {
            self.imageAttachment.url?.append(contentsOf: imageLinks)
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.imageAttachment.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentImageAttachment {
            try self.imageAttachment.isValid()
            return self.imageAttachment
        }
    }
    
    public struct LocationBuilder {
        
        private var location = Location()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String) -> Self {
            self.location.name = name
            return self
        }
        
        @discardableResult
        public func setAccuracy(_ accuracy: Float?) -> Self {
            self.location.accuracy = accuracy
            return self
        }
        
        @discardableResult
        public func setAltitude(_ altitude: Float?) -> Self {
            self.location.altitude = altitude
            return self
        }
        
        @discardableResult
        public func setCoordinate(_ coordinate: CLLocationCoordinate2D?) -> Self {
            self.location.latitude = coordinate?.latitude
            self.location.longitude = coordinate?.longitude
            return self
        }
        
        @discardableResult
        public func setRadius(_ radius: Float?) -> Self {
            self.location.radius = radius
            return self
        }
        
        @discardableResult
        public func setUnits(_ units: LocationUnits?) -> Self {
            self.location.units = units
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.location.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> Location {
            try self.location.isValid()
            return self.location
        }
    }
}
