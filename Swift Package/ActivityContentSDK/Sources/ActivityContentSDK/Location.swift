//
//  Location.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

public class Location: ActivityContentItem {
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Place
     */
    internal private(set) var type: String = "Place"
    
    /**
     The display name for the location
     */
    internal var name: String?
    
    /**
     The accuracy of the coordinates as a percentage. (e.g. "94.0" means "94.0% accurate")
     */
    internal var accuracy: Float?
    
    /**
     The altitude of the location
     */
    internal var altitude: Float?
    
    /**
     The latitude of the location
     */
    internal var latitude: Double?
    
    /**
     The longitude of the location
     */
    internal var longitude: Double?
    
    /**
     The area around the given point that comprises the location
     */
    internal var radius: Float?
    
    /**
     The units for radius and altitude (defaults to meters)
     
     - Requires: MUST be one of: cm, feet, inches, km, m, miles
     */
    internal var units: LocationUnits? = .m
    
    internal init(name: String,
                  accuracy: Float? = nil,
                  altitude: Float? = nil,
                  latitude: Double? = nil,
                  longitude: Double? = nil,
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
    
    internal init() {}
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.name == nil {
            throw ActivityContentError.missingNameField
        }
        
        if self.units == nil {
            throw ActivityContentError.missingUnitsField
        }
        
        return true
    }
}
