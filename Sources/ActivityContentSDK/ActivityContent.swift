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
        
        public struct Attachments {}
        
        public struct Hash {
            
            private var hash = ActivityContentHash()
            
            public init() {}
            public init?(json: String) {
                if let hash = ActivityContentHash(json: json) {
                    self.hash = hash
                } else {
                    return nil
                }
            }
            
            public init(keccakHashWithString content: String?) {
                self.hash = ActivityContentHash(keccakHashWithString: content)
            }
            
            public init(keccakHashWithData content: Data?) {
                self.hash = ActivityContentHash(keccakHashWithData: content)
            }
            
            @discardableResult
            public func withAlgorithm(_ algorithm: ActivityContentHash.AlgorithmType) -> Self {
                self.hash.algorithm = algorithm
                return self
            }
            
            @discardableResult
            public func withValue(_ value: String) -> Self {
                self.hash.value = value
                return self
            }
            
            @discardableResult
            public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
                self.hash.addAdditionalFields(additionalFields)
                return self
            }
            
            public func build() throws -> ActivityContentHash {
                try self.hash.isValid()
                return self.hash
            }
        }
        
        public struct Location {
            
            private var location = ActivityContentLocation()
            
            public init() {}
            public init?(json: String) {
                if let location = ActivityContentLocation(json: json) {
                    self.location = location
                } else {
                    return nil
                }
            }
            
            @discardableResult
            public func withName(_ name: String) -> Self {
                self.location.name = name
                return self
            }
            
            @discardableResult
            public func withAccuracy(_ accuracy: Float?) -> Self {
                self.location.accuracy = accuracy
                return self
            }
            
            @discardableResult
            public func withAltitude(_ altitude: Float?) -> Self {
                self.location.altitude = altitude
                return self
            }
            
            @discardableResult
            public func withCoordinate(_ coordinate: CLLocationCoordinate2D?) -> Self {
                self.location.latitude = coordinate?.latitude
                self.location.longitude = coordinate?.longitude
                return self
            }
            
            @discardableResult
            public func withRadius(_ radius: Float?) -> Self {
                self.location.radius = radius
                return self
            }
            
            @discardableResult
            public func withUnits(_ units: ActivityContentLocation.Unit?) -> Self {
                self.location.units = units
                return self
            }
            
            @discardableResult
            public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
                self.location.addAdditionalFields(additionalFields)
                return self
            }
            
            public func build() throws -> ActivityContentLocation {
                try self.location.isValid()
                return self.location
            }
        }
        
        public struct Tags {}
        
        public struct Note {
            
            private var note = ActivityContentNote()
            
            public init() {}
            public init?(json: String) {
                if let note = ActivityContentNote(json: json) {
                    self.note = note
                } else {
                    return nil
                }
            }
            
            @discardableResult
            public func withContent(_ content: String) -> Self {
                self.note.content = content
                return self
            }
            
            @discardableResult
            public func withName(_ name: String?) -> Self {
                self.note.name = name
                return self
            }
            
            @discardableResult
            public func withPublished(_ published: Date?) -> Self {
                self.note.published = published
                return self
            }
            
            @discardableResult
            public func addAttachments(_ attachments: [ActivityContentBaseAttachment?]) -> Self {
                let attachments = attachments.compactMap { $0 }
                self.note.attachment?.append(contentsOf: attachments)
                return self
            }
            
            @discardableResult
            public func addTags(_ tags: [ActivityContentBaseTag?]) -> Self {
                let tags = tags.compactMap { $0 }
                self.note.tag?.append(contentsOf: tags)
                return self
            }
            
            @discardableResult
            public func withLocation(_ location: ActivityContentLocation?) -> Self {
                self.note.location = location
                return self
            }
            
            @discardableResult
            public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
                self.note.addAdditionalFields(additionalFields)
                return self
            }
            
            public func build() throws -> ActivityContentNote {
                try self.note.isValid()
                return self.note
            }
        }
        
        public struct Profile {
            
            private var profile = ActivityContentProfile()
            
            public init() {}
            public init?(json: String) {
                if let profile = ActivityContentProfile(json: json) {
                    self.profile = profile
                } else {
                    return nil
                }
            }
            
            @discardableResult
            public func withName(_ name: String?) -> Self {
                self.profile.name = name
                return self
            }
            
            @discardableResult
            public func addIcons(_ icons: [ActivityContentImageLink?]) -> Self {
                let icons = icons.compactMap { $0 }
                self.profile.icon?.append(contentsOf: icons)
                return self
            }
            
            @discardableResult
            public func withSummary(_ summary: String?) -> Self {
                self.profile.summary = summary
                return self
            }
            
            @discardableResult
            public func withPublished(_ published: Date?) -> Self {
                self.profile.published = published
                return self
            }
            
            @discardableResult
            public func withLocation(_ location: ActivityContentLocation?) -> Self {
                self.profile.location = location
                return self
            }
            
            @discardableResult
            public func addTags(_ tags: [ActivityContentBaseTag?]) -> Self {
                let tags = tags.compactMap { $0 }
                self.profile.tag?.append(contentsOf: tags)
                return self
            }
            
            @discardableResult
            public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
                self.profile.addAdditionalFields(additionalFields)
                return self
            }
            
            public func build() throws -> ActivityContentProfile {
                try self.profile.isValid()
                return self.profile
            }
        }
    }
}

extension ActivityContent.Builders.Attachments {
    
    public struct Audio {
        
        private var audioAttachment = ActivityContentAudioAttachment()
        
        public init() {}
        public init?(json: String) {
            if let audioAttachment = ActivityContentAudioAttachment(json: json) {
                self.audioAttachment = audioAttachment
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String?) -> Self {
            self.audioAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addAudioLinks(_ audioLinks: [ActivityContentAudioLink?]) -> Self {
            let audioLinks = audioLinks.compactMap { $0 }
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
    
    public struct AudioLink {
        
        private var audioLink = ActivityContentAudioLink()
        
        public init() {}
        public init?(json: String) {
            if let audioLink = ActivityContentAudioLink(json: json) {
                self.audioLink = audioLink
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withHref(_ href: URL) -> Self {
            self.audioLink.href = href
            return self
        }
        
        @discardableResult
        public func withMediaType(_ mediaType: ActivityContentAudioLink.AudioMediaType) -> Self {
            self.audioLink.mediaType = mediaType
            return self
        }
        
        @discardableResult
        public func addHashes(_ hashes: [ActivityContentHash?]) -> Self {
            let hashes = hashes.compactMap { $0 }
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
    
    public struct Image {
        
        private var imageAttachment = ActivityContentImageAttachment()
        
        public init() {}
        public init?(json: String) {
            if let imageAttachment = ActivityContentImageAttachment(json: json) {
                self.imageAttachment = imageAttachment
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String?) -> Self {
            self.imageAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addImageLinks(_ imageLinks: [ActivityContentImageLink?]) -> Self {
            let imageLinks = imageLinks.compactMap { $0 }
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
    
    public struct ImageLink {
        
        private var imageLink = ActivityContentImageLink()
        
        public init() {}
        public init?(json: String) {
            if let imageLink = ActivityContentImageLink(json: json) {
                self.imageLink = imageLink
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withHref(_ href: URL) -> Self {
            self.imageLink.href = href
            return self
        }
        
        @discardableResult
        public func withMediaType(_ mediaType: ActivityContentImageLink.ImageMediaType) -> Self {
            self.imageLink.mediaType = mediaType
            return self
        }
        
        @discardableResult
        public func addHashes(_ hashes: [ActivityContentHash?]) -> Self {
            let hashes = hashes.compactMap { $0 }
            self.imageLink.hash?.append(contentsOf: hashes)
            return self
        }
        
        @discardableResult
        public func withSize(_ size: CGSize?) -> Self {
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
    
    public struct Video {
        
        private var videoAttachment = ActivityContentVideoAttachment()
        
        public init() {}
        public init?(json: String) {
            if let videoAttachment = ActivityContentVideoAttachment(json: json) {
                self.videoAttachment = videoAttachment
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String?) -> Self {
            self.videoAttachment.name = name
            return self
        }
        
        @discardableResult
        public func addVideoLinks(_ videoLinks: [ActivityContentVideoLink?]) -> Self {
            let videoLinks = videoLinks.compactMap { $0 }
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
    
    public struct VideoLink {
        
        private var videoLink = ActivityContentVideoLink()
        
        public init() {}
        public init?(json: String) {
            if let videoLink = ActivityContentVideoLink(json: json) {
                self.videoLink = videoLink
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withHref(_ href: URL) -> Self {
            self.videoLink.href = href
            return self
        }
        
        @discardableResult
        public func withMediaType(_ mediaType: ActivityContentVideoLink.VideoMediaType) -> Self {
            self.videoLink.mediaType = mediaType
            return self
        }
        
        @discardableResult
        public func addHashes(_ hashes: [ActivityContentHash?]) -> Self {
            let hashes = hashes.compactMap { $0 }
            self.videoLink.hash?.append(contentsOf: hashes)
            return self
        }
        
        @discardableResult
        public func withSize(_ size: CGSize?) -> Self {
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
    
    public struct Link {
        
        private var linkAttachment = ActivityContentLinkAttachment()
        
        public init() {}
        public init?(json: String) {
            if let linkAttachment = ActivityContentLinkAttachment(json: json) {
                self.linkAttachment = linkAttachment
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String?) -> Self {
            self.linkAttachment.name = name
            return self
        }
        
        @discardableResult
        public func withHref(_ href: URL) -> Self {
            self.linkAttachment.href = href
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.linkAttachment.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentLinkAttachment {
            try self.linkAttachment.isValid()
            return self.linkAttachment
        }
    }
}

extension ActivityContent.Builders.Tags {
    
    public struct Hashtag {
        
        private var hashtag = ActivityContentHashtag()
        
        public init() {}
        public init?(json: String) {
            if let hashtag = ActivityContentHashtag(json: json) {
                self.hashtag = hashtag
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String) -> Self {
            self.hashtag.name = name
            return self
        }
        
        @discardableResult
        public func addAdditionalFields(_ additionalFields: [String : Any]) -> Self {
            self.hashtag.addAdditionalFields(additionalFields)
            return self
        }
        
        public func build() throws -> ActivityContentHashtag {
            try self.hashtag.isValid()
            return self.hashtag
        }
    }
    
    public struct Mention {
        
        private var mention = ActivityContentMention()
        
        public init() {}
        public init?(json: String) {
            if let mention = ActivityContentMention(json: json) {
                self.mention = mention
            } else {
                return nil
            }
        }
        
        @discardableResult
        public func withName(_ name: String?) -> Self {
            self.mention.name = name
            return self
        }
        
        @discardableResult
        public func withDSNPUserId(_ dsnpUserId: DSNPUserId) -> Self {
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
