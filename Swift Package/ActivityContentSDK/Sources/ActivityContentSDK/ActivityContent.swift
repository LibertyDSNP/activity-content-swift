//
//  ActivityContent.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/22/21.
//

import Foundation

public class ActivityContent {
    
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
        value: String) -> Hash {
            
            return Hash(
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
