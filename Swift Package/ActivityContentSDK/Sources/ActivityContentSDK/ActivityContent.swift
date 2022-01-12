//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation
import CoreGraphics
import CoreLocation

public class ActivityContent {
   
    public class NoteBuilder {

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
        
        public func build() throws -> Note {
            try self.note.isValid()
            return self.note
        }
    }
    
    public class ProfileBuilder {

        private var profile = Profile()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.profile.name = name
            return self
        }
        
        @discardableResult
        public func addIcons(_ icons: [ImageLink]) -> Self {
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
        
        public func build() throws -> Profile {
            try self.profile.isValid()
            return self.profile
        }
    }
    
    public class LinkAttachmentBuilder {
        
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
        
        public func build() throws -> LinkAttachment {
            try self.linkAttachment.isValid()
            return self.linkAttachment
        }
    }
    
    public class AudioAttachmentBuilder {
        
        private var audioAttachment = AudioAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.audioAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addAudioLinks(_ audioLinks: [AudioLink]) -> Self {
            self.audioAttachment.url?.append(contentsOf: audioLinks)
            return self
        }
        
        @discardableResult
        public func addDuration(_ duration: TimeInterval?) -> Self {
            self.audioAttachment.duration = duration
            return self
        }
        
        public func build() throws -> AudioAttachment {
            try self.audioAttachment.isValid()
            return self.audioAttachment
        }
    }
    
    public class VideoAttachmentBuilder {
        
        private var videoAttachment = VideoAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.videoAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addVideoLinks(_ videoLinks: [VideoLink]) -> Self {
            self.videoAttachment.url?.append(contentsOf: videoLinks)
            return self
        }
        
        @discardableResult
        public func addDuration(_ duration: TimeInterval?) -> Self {
            self.videoAttachment.duration = duration
            return self
        }
        
        public func build() throws -> VideoAttachment {
            try self.videoAttachment.isValid()
            return self.videoAttachment
        }
    }
    
    public class AudioLinkBuilder {
     
        private var audioLink = AudioLink()
        
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

        public func build() throws -> AudioLink {
            try self.audioLink.isValid()
            return self.audioLink
        }
    }
    
    public class VideoLinkBuilder {
     
        private var videoLink = VideoLink()
        
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

        public func build() throws -> VideoLink {
            try self.videoLink.isValid()
            return self.videoLink
        }
    }
    
    public class HashtagBuilder {
        
        private var hashtag = Hashtag()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String) -> Self {
            self.hashtag.name = name
            return self
        }
        
        public func build() throws -> Hashtag {
            try self.hashtag.isValid()
            return self.hashtag
        }
    }
    
    public class MentionBuilder {
        
        private var mention = Mention()
        
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
        
        public func build() throws -> Mention {
            try self.mention.isValid()
            return self.mention
        }
    }
    
    public class HashBuilder {
        
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
        
        public func build() throws -> Hash {
            try self.hash.isValid()
            return self.hash
        }
    }
    
    public class ImageLinkBuilder {
        
        private var imageLink = ImageLink()
        
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

        public func build() throws -> ImageLink {
            try self.imageLink.isValid()
            return self.imageLink
        }
    }
    
    public class ImageAttachmentBuilder {
        
        private var imageAttachment = ImageAttachment()
        
        public init() {}
        
        @discardableResult
        public func setName(_ name: String?) -> Self {
            self.imageAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addImageLinks(_ imageLinks: [ImageLink]) -> Self {
            self.imageAttachment.url?.append(contentsOf: imageLinks)
            return self
        }
        
        public func build() throws -> ImageAttachment {
            try self.imageAttachment.isValid()
            return self.imageAttachment
        }
    }
    
    public class LocationBuilder {
        
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
        
        public func build() throws -> Location {
            try self.location.isValid()
            return self.location
        }
    }
}
