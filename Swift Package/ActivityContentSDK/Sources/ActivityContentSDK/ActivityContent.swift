//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation


public class ActivityContent {
    
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
    
    
    
    
    public static func createNote(
        content: String,
        mediaType: String,
        name: String? = nil,
        published: Date? = nil,
        attachment: [BaseAttachment]? = nil,
        tag: [BaseTag]? = nil,
        location: Location? = nil) -> Note {
            
            return Note(
                content: content,
                mediaType: mediaType,
                name: name,
                published: published,
                attachment: attachment,
                tag: tag,
                location: location)
        }
    
    public static func createLocation(
        name: String,
        accuracy: Float? = nil,
        altitude: Float? = nil,
        latitude: Float? = nil,
        longitude: Float? = nil,
        radius: Float? = nil,
        units: LocationUnits? = nil) -> Location {
            
            return Location(
                name: name,
                accuracy: accuracy,
                altitude: altitude,
                latitude: latitude,
                longitude: longitude,
                radius: radius,
                units: units)
        }
    
    public static func createImageLink(
        href: URL,
        mediaType: String,
        hash: [Hash],
        height: Float? = nil,
        width: Float? = nil) throws -> ImageLink {
            
            return try ImageLink(
                href: href,
                mediaType: mediaType,
                hash: hash,
                height: height,
                width: width)
        }
    
    public static func createHash(
        algorithm: String,
        value: String) throws -> Hash {
            
            return try Hash(
                algorithm: algorithm,
                value: value)
        }
    
    public static func createImageAttachment(
        url: [ImageLink],
        name: String? = nil) -> ImageAttachment {
            
            return ImageAttachment(
                url: url, name: name)
        }
    
    public static func createHashtag(name: String) -> Hashtag {
        
        return Hashtag(name: name)
    }
    
}
