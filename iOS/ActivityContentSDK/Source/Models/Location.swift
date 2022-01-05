//
//  Location.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

class Location: Codable {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Place
     */
    public private(set) var type: String = "Place"
    
    /**
     The display name for the location
     */
    public var name: String
    
    /**
     The accuracy of the coordinates as a percentage. (e.g. "94.0" means "94.0% accurate")
     */
    public var accuracy: Float?
    
    /**
     The altitude of the location
     */
    public var altitude: Float?
    
    /**
     The latitude of the location
     */
    public var latitude: Float?
    
    /**
     The longitude of the location
     */
    public var longitude: Float?
    
    /**
     The area around the given point that comprises the location
     */
    public var radius: Float?
    
    /**
     The units for radius and altitude (defaults to meters)
     
     - Requires: MUST be one of: cm, feet, inches, km, m, miles
     */
    public var units: LocationUnits? = .m
    
    init(name: String,
         accuracy: Float? = nil,
         altitude: Float? = nil,
         latitude: Float? = nil,
         longitude: Float? = nil,
         radius: Float? = nil,
         units: LocationUnits? = .m) {
        self.name = name
        self.accuracy = accuracy
        self.altitude = altitude
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.units = units
    }
}
